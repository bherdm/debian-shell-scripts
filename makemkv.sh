#! /usr/bin/bash

#MAKEMKV
sudo apt-get install -y \
  build-essential \
  pkg-config \
  libc6-dev \
  libssl-dev \
  libexpat1-dev \
  libavcodec-dev \
  libgl1-mesa-dev \
  qtbase5-dev \
  zlib1g-dev
rm -rf ~/makemkv
mkdir ~/makemkv
cd ~/makemkv
wget -O makemkv-bin-1.17.8.tar.gz https://www.makemkv.com/download/makemkv-bin-1.17.8.tar.gz
tar -xvf makemkv-bin-1.17.8.tar.gz
wget -O makemkv-oss-1.17.8.tar.gz https://www.makemkv.com/download/makemkv-oss-1.17.8.tar.gz
tar -xvf makemkv-oss-1.17.8.tar.gz
  #ffmpeg
sudo apt-get update -qq && sudo apt-get -y install \
  autoconf \
  automake \
  build-essential \
  cmake \
  git-core \
  libass-dev \
  libfreetype6-dev \
  libgnutls28-dev \
  libmp3lame-dev \
  libsdl2-dev \
  libtool \
  libva-dev \
  libvdpau-dev \
  libvorbis-dev \
  libxcb1-dev \
  libxcb-shm0-dev \
  libxcb-xfixes0-dev \
  meson \
  ninja-build \
  pkg-config \
  texinfo \
  wget \
  yasm \
  zlib1g-dev
mkdir ~/makemkv/ffmpeg_sources
cd ~/makemkv/ffmpeg_sources && \
wget -O ffmpeg-7.1.tar.bz2 https://ffmpeg.org//releases/ffmpeg-7.1.tar.bz2 && \
tar xjvf ffmpeg-7.1.tar.bz2 && \
cd ffmpeg && \
    #nasm
cd ~/makemkv/ffmpeg_sources && \
wget https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/nasm-2.16.01.tar.bz2 && \
tar xjvf nasm-2.16.01.tar.bz2 && \
cd nasm-2.16.01 && \
./autogen.sh && \
PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" && \
make && \
make install
    #libfdk_aac
cd ~/makemkv/ffmpeg_sources && \
git -C fdk-aac pull 2> /dev/null || git clone --depth 1 https://github.com/mstorsjo/fdk-aac && \
cd fdk-aac && \
autoreconf -fiv && \
./configure --prefix="$HOME/ffmpeg_build" --disable-shared && \
make && \
make install
    #ffmpeg
cd ~/makemkv/ffmpeg_sources/ffmpeg
./configure --prefix=/tmp/ffmpeg --enable-static --disable-shared --enable-pic --enable-libfdk-aac
make install
# Make MKV
cd ~/makemkv/makemkv-oss-1.17.8
./configure
make
sudo make install
cd ~/makemkv/makemkv-bin-1.17.8
make
sudo make install
#rm -rf ~/makemkv
#rm -rf ~/ffmpeg
