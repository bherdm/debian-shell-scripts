#! /usr/bin/bash
#chmod u+x hello_debian.sh
sudo -S sh -c 'echo "Defaults timestamp_timeout=-1" >> /etc/sudoers.d/timeout'
echo "Hello Debian!"


sudo apt-get update -y
sudo apt upgrade -y
sudo apt-get install -y \
  git-all \
  espeak \
  vlc

#FIREFOX
#Create a directory to store APT repository keys if it doesn't exist:
sudo install -d -m 0755 /etc/apt/keyrings

#Import the Mozilla APT repository signing key:
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
#If you do not have wget installed, you can install it with:
sudo apt-get install -y \
  wget
#The fingerprint should be 35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3. You may check it with the following command:
gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
#Next, add the Mozilla APT repository to your sources list:
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
#Configure APT to prioritize packages from the Mozilla repository:
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla
#Update your package list, and install the Firefox .deb package:
sudo apt-get update && sudo apt-get install -y firefox

#UBLOCK ORIGIN
sudo apt-get install -y python3
python3 -m webbrowser -t  https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/ &

#VISUAL STUDIO CODE
sudo apt-get install -y snapd
sudo snap install --classic code

#VISUAL STUDIO CODE
sudo apt-get install -y snapd
sudo snap install plex-desktop

#GitHub CLI
espeak "Downloading and installing GitHub C L I"
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
        && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

#GIMP
sudo apt-get install -y flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref 

#Blender

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


mkdir ~/git
#bherdm/Debian-Shell-Scripts
cd ~/git
git clone https://github.com/bherdm/debian-shell-scripts.git
#xdg-open .
bash ~/git/debian-shell-scripts/benchmark_dependencies.sh
# Wait
read -p "Press Enter to exit..."
