#! /usr/bin/bash
mkdir ~/git/debian-shell-scripts/benchmark_repos/
cd ~/git/debian-shell-scripts/benchmark_repos/

#git
git_file_name="git-2.47.1"
if [ ! -e $git_file_name.tar.xz ]; then
  espeak "Downloading git from kernel dot org."
  wget https://www.kernel.org/pub/software/scm/git/$git_file_name.tar.xz
fi
if [ ! -e $git_file_name ]; then
  tar -xf "$git_file_name.tar.xz"
fi

#GODOT 4.3
sudo apt-get update
sudo apt-get install -y \
  build-essential \
  scons \
  pkg-config \
  libx11-dev \
  libxcursor-dev \
  libxinerama-dev \
  libgl1-mesa-dev \
  libglu1-mesa-dev \
  libasound2-dev \
  libpulse-dev \
  libudev-dev \
  libxi-dev \
  libxrandr-dev \
  libwayland-dev \
  mingw-w64
espeak "Cloning the four point three branch of the [[gV]]dough engine."
if [ ! -e "godot" ]; then
  git clone --depth 1 --branch 4.3 https://github.com/godotengine/godot.git
fi

#Godot-for-OUYA
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
espeak "Cloning the main branch of [[gV]]dough for OUYA."
if [ ! -e "godot-for-ouya" ]; then
  git clone --depth 1 --branch ouya https://github.com/bherdm/godot-for-ouya.git
fi

#Inkscape
sudo add-apt-repository 'deb http://archive.ubuntu.com/ubuntu lunar main'
inkscape_file_name="inkscape_dependencies.sh"
if [ ! -e $inkscape_file_name ]; then
  wget -v https://gitlab.com/inkscape/inkscape-ci-docker/-/raw/master/install_dependencies.sh -O $inkscape_file_name
fi
bash inkscape_dependencies.sh --full
rm $inkscape_file_name

espeak "Cloning the one point four branch of Inkscape."
if [ ! -e "inkscape" ]; then
  git clone --recurse-submodules --depth 1 --branch INKSCAPE_1_4 https://gitlab.com/inkscape/inkscape.git
fi

# Finished
espeak "Dependencies acquired. Ready for benchmarking." &
# Wait
#read -p "Press Enter to exit..."



# sudo apt-get install -y \
#   dh-autoreconf \
#   libcurl4-gnutls-dev \
#   libexpat1-dev \
#   gettext \
#   libz-dev \
#   libssl-dev \
#   asciidoc \
#   xmlto \
#   docbook2x \
#   install-info \
#   build-essential \
#   scons \
#   pkg-config \
#   libx11-dev \
#   libxcursor-dev \
#   libxinerama-dev \
#   libgl1-mesa-dev \
#   libglu1-mesa-dev \
#   libasound2-dev \
#   libpulse-dev \
#   libudev-dev \
#   libxi-dev \
#   libxrandr-dev \
#   libwayland-dev \
#   libembree-dev \
#   libenet-dev \
#   libfreetype-dev \
#   libpng-dev \
#   zlib1g-dev \
#   libgraphite2-dev \
#   libharfbuzz-dev \
#   libogg-dev \
#   libtheora-dev \
#   libvorbis-dev \
#   libwebp-dev \
#   libmbedtls-dev \
#   libminiupnpc-dev \
#   libpcre2-dev \
#   libzstd-dev \
#   libsquish-dev \
#   libicu-dev \
#   firefox




# espeak "Compiling git from source."
# cd "git-2.47.1"
# make configure
# ./configure --prefix=/usr
# make all doc info
# sudo make install install-doc install-html install-info
# cd ..

# mkdir git

# espeak "Downloading Debian Shell Scripts repo"
# cd git
# git clone https://github.com/bherdm/debian-shell-scripts.git
# cd ..




# espeak "Downloading Blender"
# sudo apt update
# sudo apt install -y \
#   python3 \
#   git-lfs
# cd git
# if [ ! -e "blender" ]; then
#     git clone --depth 1 --branch blender-v4.3-release https://projects.blender.org/blender/blender.git
# fi
# cd blender/
# ./build_files/build_environment/install_linux_packages.py --all
# sudo apt update
# sudo apt install -y \
#   build-essential \
#   git \
#   git-lfs \
#   subversion \
#   cmake \
#   libx11-dev \
#   libxxf86vm-dev \
#   libxcursor-dev \
#   libxi-dev \
#   libxrandr-dev \
#   libxinerama-dev \
#   libegl-dev \
#   libwayland-dev \
#   wayland-protocols \
#   libxkbcommon-dev \
#   libdbus-1-dev \
#   linux-libc-dev
# ./build_files/utils/make_update.py --use-linux-libraries
# espeak "Compiling Blender four point three."
# make update
# make
# cd ..
# cd ..

# espeak "Downloading and installing V S Code"
# sudo snap install --classic code


# # Get system memory total
# Kilobytes_ram=$(grep MemTotal /proc/meminfo | awk '{print $2}')
# Megabytes_ram=$((Kilobytes_ram/1000))
# # Get logic core count
# cpu_cores=$(nproc)
# halfcores=$((cpu_cores / 2))
# determined_lto="poop"
# if [ "$Megabytes_ram" -lt 4000 ]; then
# 	determined_lto="none"
# elif [ "$Megabytes_ram" -lt 8000 ]; then
# 	determined_lto="thin"
# else
# 	determined_lto="full"
# fi


# espeak "Compiling [[gV]]dough four point three" &
# cd godot
# scons platform=linuxbsd -j$halfcores
# cd ..
# cd ..


#cd inkscape
#mkdir build
#cd build
#espeak "Compiling Inkscape" &
#cmake -S .. -B . -DCMAKE_INSTALL_PREFIX=${PWD}/install_dir -DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache
#make -j2
#make install
#cd ..
#cd ..


# echo "$Megabytes_ram MB of RAM"
# echo "$cpu_cores logical cores"

# python3 -m webbrowser -t  https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/ &

# git --version

# # Get end time
# end_time=$(date +%s)

# # Calculate elapsed time
# elapsed_time=$((end_time - start_time))

# # Log the times
# echo "Script started at: $(date -d @$start_time)"
# echo "Script ended at: $(date -d @$end_time)"
# echo "Elapsed time: $elapsed_time seconds"
