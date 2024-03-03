FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04

WORKDIR $HOME/app

RUN apt-get update && apt-get install -y \
    git \
    python3.10 \
    python3-pip
RUN  apt-get update && apt-get install -y \
    wget \
    python3-venv \
    libgl1 \
    libglib2.0-0
RUN apt-get update && apt-get install -y \
    libgoogle-perftools4 \
    libtcmalloc-minimal4

# Python Evn
ENV VIRTUAL_ENV=/app/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121
#RUN pip3 torch torchvision --index-url https://download.pytorch.org/whl/test/rocm5.6
RUN git clone https://github.com/changxubo/SDWebUI.git
RUN cd /app/SDWebUI && git fetch && git checkout f537155a60d9b070919c781b841253464ad84b54
RUN pip3 install -r /app/SDWebUI/requirements.txt

EXPOSE 7860
CMD ["python3", "-u", "/app/SDWebUI/launch.py","--reinstall-xformers","--server-name","0.0.0.0","--port","7860"]