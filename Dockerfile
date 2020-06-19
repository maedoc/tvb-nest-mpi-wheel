FROM ubuntu

ARG MPICH_VER=3.3.2

# avoid tzdata install asking for an answer
ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update \
 && apt-get install -y g++ gcc gfortran make curl build-essential cmake \
                       python3-distutils python3-dev python3-pip libltdl-dev \
                       libreadline-dev libncurses-dev libgsl-dev liblapack-dev

WORKDIR /usr/src

RUN curl -L http://www.mpich.org/static/downloads/$MPICH_VER/mpich-$MPICH_VER.tar.gz | \
	tar xzf - \
 && cd mpich-$MPICH_VER \
 && ./configure --disable-fortran --prefix=/usr \
 && make -j4 install

RUN pip3 install --upgrade pip
RUN pip3 install nose numpy cython Pillow matplotlib mpi4py scipy elephant \
 				tvb-data tvb-gdist tvb-library