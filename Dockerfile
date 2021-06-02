FROM debian:latest as base


RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        build-essential \
        ca-certificates \
        cmake \
        bash-completion \
        tar \
        curl \
        unzip \
        git \
        libboost-dev \
        libboost-program-options-dev \ 
        libboost-date-time-dev \
        libboost-filesystem-dev \
        libboost-regex-dev \
        libboost-serialization-dev \
        libboost-system-dev \
        libboost-thread-dev


FROM base as src
RUN git clone --branch development https://github.com/revbayes/revbayes.git /revbayes
ENV PATH=$PATH:/revbayes

RUN cd /revbayes/projects/cmake \
        && rm -rf build/ \
        && ./build.sh\
        && mv rb /revbayes/rb

FROM src as prod

ENTRYPOINT ["/revbayes/rb"]