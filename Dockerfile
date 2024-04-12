FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04
# FROM nvidia/cuda:12.0.1-cudnn8-runtime-ubuntu22.04
EXPOSE 18888
ENV EX_IP=0.0.0.0
ENV EX_PORT=18888
WORKDIR /
RUN apt-get update \
        && apt-get install -y python3-pip espeak gosu libsndfile1-dev emacs git \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* \
        && git clone https://github.com/w-okada/voice-changer.git \
        && chmod 0777 /voice-changer/server
WORKDIR /voice-changer/server
RUN pip install numpy==1.23.5 \
        && pip install fairseq \
        && pip install pyworld==0.3.3 --no-build-isolation \
        && pip install -r requirements.txt
COPY /run.sh ./
ENTRYPOINT ["/bin/bash","run.sh"]
# ENTRYPOINT ["/usr/bin/python3","MMVCServerSIO.py"] 
# CMD ["-p 18888","--https true","--content_vec_500 pretrain/checkpoint_best_legacy_500.pt","--content_vec_500_onnx pretrain/content_vec_500.onnx","--content_vec_500_onnx_on true","--hubert_base pretrain/hubert_base.pt","--hubert_base_jp pretrain/rinna_hubert_base_jp.pt","--hubert_soft pretrain/hubert/hubert-soft-0d54a1f4.pt","--nsf_hifigan pretrain/nsf_hifigan/model","--crepe_onnx_full pretrain/crepe_onnx_full.onnx","--crepe_onnx_tiny pretrain/crepe_onnx_tiny.onnx","--rmvpe pretrain/rmvpe.pt","--model_dir model_dir","--samples samples.json"]
