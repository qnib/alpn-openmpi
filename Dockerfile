FROM qnib/alpn-infiniband

RUN apk update && apk upgrade && \
    apk add vim wget tar g++ make libgcrypt-dev perl unzip flex autoconf automake libtool
RUN wget -qO /tmp/openmpi.zip https://github.com/open-mpi/ompi/archive/master.zip && \
    cd /opt/ && \
    unzip -q /tmp/openmpi.zip && \ 
    echo
RUN cd /opt/ompi-master && \
    ./autogen.pl && \ 
    sh ./configure && make && make install
ADD hello_mpi.c /usr/local/src/
RUN mpicc -o /usr/local/bin/hello_mpi /usr/local/src/hello_mpi.c
