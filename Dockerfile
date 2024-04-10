FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04
# FROM nvidia/cuda:12.0.1-cudnn8-runtime-ubuntu22.04
EXPOSE 18888
WORKDIR /
RUN apt-get update \
        && apt-get install -y python3-pip espeak gosu libsndfile1-dev emacs git \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* \
        && git clone https://github.com/w-okada/voice-changer.git \
        && chmod 0777 /voice-changer/server
WORKDIR /voice-changer/server
COPY /run.sh /voice-changer/server
RUN pip install numpy==1.23.5 \
        && pip install pyworld==0.3.3 --no-build-isolation \
        && pip install -r requirements.txt
CMD ["/bin/bash"，"run.sh" ]
