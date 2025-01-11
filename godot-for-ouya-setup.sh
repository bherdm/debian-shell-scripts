#! /usr/bin/bash
#Godot-for-OUYA
export BUILD_REVISION="OUYA"

sudo apt-get install -y \
  build-essential \
  scons \
  pkg-config \
  libx11-dev \
  libxcursor-dev \
  libxinerama-dev \
  libgl1-mesa-dev \
  libglu-dev \
  libasound2-dev \
  libpulse-dev \
  libfreetype6-dev \
  libssl-dev \
  libudev-dev \
  libxrandr-dev

cd $HOME
mkdir git
cd git

if [ ! -e "godot-for-ouya" ]; then
  espeak "Cloning [[gV]]dough for OUYA."
  git clone https://github.com/bherdm/godot-for-ouya.git
fi
cd git checkout remotes/origin/debian

# Get logic core count
cpu_cores=$(nproc)
compile_cores=$((cpu_cores / 2))
if [ compile_cores != 1 ]; then
  ((compile_cores+=1))
fi
cd $HOME/git/godot-for-ouya

# Build editor for linux
scons platform=x11 -j$compile_cores

#Java 8
sudo apt install -y openjdk-8-jdk
export ANDROID_JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

#Android SDK
export ANDROID_HOME="$HOME/git/godot-for-ouya/bin/Android/sdk"
export ANDROID_NDK_ROOT="$HOME/git/godot-for-ouya/bin/Android/sdk/ndk/17.2.4988734"
export ANDROID_NDK_HOME="$HOME/git/godot-for-ouya/bin/Android/sdk/ndk/17.2.4988734"
mkdir -p $ANDROID_HOME
cd $ANDROID_HOME
cd ..
sdk_cmdline="commandlinetools-linux-9123335_latest.zip"
if [ ! -e "$sdk_cmdline" ]; then
  espeak "Downloading Android SDK command line tools version 8 point oh."
  wget -O $sdk_cmdline https://dl.google.com/android/repository/$sdk_cmdline
fi
unzip $sdk_cmdline
rm -rf $ANDROID_HOME/cmdline-tools/
mkdir -p $ANDROID_HOME/cmdline-tools
mv cmdline-tools/ $ANDROID_HOME/cmdline-tools/8.0/
cd $ANDROID_HOME/cmdline-tools/8.0/bin/
./sdkmanager --install "platforms;android-23" "platform-tools" "build-tools;26.0.1" "build-tools;28.0.3" "ndk;17.2.4988734" "sources;android-23"
cd $ANDROID_HOME/cmdline-tools/8.0/bin/
./sdkmanager --licenses
cd $ANDROID_HOME
cd ..
if [ ! -e "libtinfo.deb" ]; then
  wget -O libtinfo.deb http://security.ubuntu.com/ubuntu/pool/universe/n/ncurses/libtinfo5_6.3-2ubuntu0.1_amd64.deb
fi
sudo dpkg -i libtinfo.deb

# Build export template for Android
cd $HOME/git/godot-for-ouya
scons platform=android target=debug android_arch=armv7 -j$compile_cores
scons platform=android target=release android_arch=armv7 -j$compile_cores
cd $HOME/git/godot-for-ouya/platform/android/java
./gradlew build


#OSX Cross
cd $HOME/git
if [ ! -e "osxcross" ]; then
  git clone --depth=1 https://github.com/tpoechtrager/osxcross.git
fi
sudo apt-get install -y \
  clang \
  make \
  libssl-devel \
  lzma-devel \
  libxm12-devel
