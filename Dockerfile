FROM qnib/alpn-infiniband

RUN apk update && apk upgrade && \
    apk add vim wget tar g++ make libgcrypt-dev perl unzip flex autoconf automake libtool && \
    wget -qO /tmp/openmpi.zip https://github.com/open-mpi/ompi/archive/master.zip && \
    cd /opt/ && \
    unzip -q /tmp/openmpi.zip && \ 
    cd /opt/ompi-master && \
    ./autogen.pl && \ 
    sh ./configure --enable-orterun-prefix-by-default && \
    make -j4 && make install && \
    apk del g++ make perl tar wget libgcrypt-dev libtool automake autoconf flex unzip && \
    rm -rf /var/cache/apk/*
ADD hello_mpi.c /usr/local/src/
RUN mpicc -o /usr/local/bin/hello_mpi /usr/local/src/hello_mpi.c
