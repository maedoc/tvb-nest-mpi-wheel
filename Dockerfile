FROM ubuntu

ARG MPICH_VER=3.3.2

RUN apt-get update \
 && apt-get install -y g++ gcc gfortran make

WORKDIR /usr/local/src

RUN curl -L http://www.mpich.org/static/downloads/$MPICH_VER/mpich-$MPICH_VER.tar.gz |
	tar xf - \
 && cd mpich-$MPICH_VER \
 && ./configure --disable-fortran --prefix=/usr/local \
 && make -j4 install
