FROM rayproject/ray:latest

RUN addgroup --system raygroup && adduser  -h rayuser -s /bin/sh -D -S rayuser -G raygroup
#USER rayuser

RUN cd /home
RUN mkdir -p /rayuser/py-projects

WORKDIR /home/rayuser/py-projects

# COPY pyray_entrypoint.sh .
ADD /pyray .
#RUN cd pyray

#install alldependences
RUN apt-get update && apt-get install -y zlib1g-dev libgl1-mesa-dev libgtk2.0-dev && apt-get clean
RUN pip install --no-cache-dir -U pip \
    gym[atari] \
    opencv-python-headless==4.3.0.36 \
    tensorflow \
    lz4 \
    pytest-timeout \
    smart_open \
    tensorflow_probability \
    dm_tree \
    h5py   # Mutes FutureWarnings \
    bayesian-optimization \
    hyperopt \
    ConfigSpace==0.4.10 \
    sigopt \ 
    nevergrad \
    scikit-optimize \
    hpbandster \
    lightgbm \
    xgboost \
    torch \
    torchvision \
    tensorboardX \
    dragonfly-opt \
    zoopt \
    tabulate \ 
    mlflow \
    pytest-remotedata>=0.3.1 \
    matplotlib \
    jupyter \
    pandas

RUN chmod +x ray-head.sh
RUN chmod +x ray-worker.sh

COPY /pyray/ray.service /lib/systemd/system/

#configure ray.service we will use entrypoint sh
#RUN systemctl enable ray.service
#RUN service enable ray.service
#RUN service daemon-reload

EXPOSE 6379/tcp
EXPOSE 8265/tcp

#setup entrypoint
ENTRYPOINT ["/bin/sh","ray-head.sh"]
#CMD ["python", "pyray/pyray_init.py"]