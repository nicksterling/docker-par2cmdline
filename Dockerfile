FROM ubuntu:22.04 as base

WORKDIR /data

RUN apt-get update && \
    apt-get install -y git build-essential automake && \
    git clone https://github.com/Parchive/par2cmdline.git && \
    cd par2cmdline && \
    aclocal && \
    automake --add-missing && \
    autoconf && \
    ./configure && \
    make && \
    make check && \
    make install 


FROM ubuntu:22.04 as app
RUN apt-get update && apt-get install libgomp1 --no-install-recommends -y && rm -rf /var/lib/apt/lists/*
COPY --from=base /usr/local/bin/par* /usr/local/bin/
