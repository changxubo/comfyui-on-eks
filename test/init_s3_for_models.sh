#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <aws-region>"
    exit 1
fi

region=$1
account=$(aws sts get-caller-identity --query Account --output text)
bucket="comfyui-models-$account-$region"

dirs=(checkpoints clip clip_vision configs controlnet diffusers embeddings gligen hypernetworks loras style_models unet upscale_models vae vae_approx)
for dir in "${dirs[@]}"
do
    mkdir -p ~/comfyui-models/$dir
    touch ~/comfyui-models/$dir/put_here
done

#curl -L -o ~/comfyui-models/checkpoints/sd_xl_base_1.0.safetensors "https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors?download=true"
#curl -L -o ~/comfyui-models/checkpoints/sd_xl_refiner_1.0.safetensors "https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors?download=true"

#curl -L -o ~/comfyui-models/checkpoints/sd21-unclip-h.ckpt "https://huggingface.co/stabilityai/stable-diffusion-2-1-unclip/resolve/main/sd21-unclip-h.ckpt?download=true"
#curl -L -o ~/comfyui-models/checkpoints/sd21-unclip-l.ckpt"https://huggingface.co/stabilityai/stable-diffusion-2-1-unclip/resolve/main/sd21-unclip-l.ckpt?download=true"

#curl -L -o ~/comfyui-models/checkpoints/dreamshaper_8.safetensors "https://civitai-delivery-worker-prod.5ac0637cfd0766c97916cefa3764fbdf.r2.cloudflarestorage.com/318995/model/ghostmixV20Fp16.FmfH.safetensors?X-Amz-Expires=86400&response-content-disposition=attachment%3B%20filename%3D%22ghostmix_v20Bakedvae.safetensors%22&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=e01358d793ad6966166af8b3064953ad/20240219/us-east-1/s3/aws4_request&X-Amz-Date=20240219T102045Z&X-Amz-SignedHeaders=host&X-Amz-Signature=522b50c2acc3dbaab52b091dbcdb16b03073d434cfad12d950f89a5ae2ff5cbc

#curl -L -o ~/comfyui-models/checkpoints/sdxl_lightning_8step.safetensors "https://huggingface.co/ByteDance/SDXL-Lightning/resolve/main/sdxl_lightning_8step.safetensors?download=true"
#curl -L -o ~/comfyui-models/lora/sdxl_lightning_8step_lora.safetensors "https://huggingface.co/ByteDance/SDXL-Lightning/resolve/main/sdxl_lightning_8step_lora.safetensors?download=true"

curl -L -o ~/comfyui-models/checkpoints/thinkdiffusionxl.Fowd.safetensors "https://civitai-delivery-worker-prod.5ac0637cfd0766c97916cefa3764fbdf.r2.cloudflarestorage.com/model/2087867/thinkdiffusionxl.Fowd.safetensors?X-Amz-Expires=86400&response-content-disposition=attachment%3B%20filename%3D%22thinkdiffusionxl_v10.safetensors%22&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=e01358d793ad6966166af8b3064953ad/20240303/us-east-1/s3/aws4_request&X-Amz-Date=20240303T124343Z&X-Amz-SignedHeaders=host&X-Amz-Signature=54e17b41b43d55f5f6cd43b03339df8173e5579ade82fa8d29a4d78bc8d0735b"
curl -L -o ~/comfyui-models/controlnet/control-lora-depth-rank256.safetensors "https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-depth-rank256.safetensors?download=true"

aws s3 sync ~/comfyui-models s3://$bucket/ --region $region
rm -rf ~/comfyui-models