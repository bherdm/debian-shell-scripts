#! /usr/bin/bash
#chmod u+x hello_debian.sh
sudo -S sh -c 'echo "Defaults timestamp_timeout=-1" >> /etc/sudoers.d/timeout'


# cd git
# cd blender
# espeak "Compiling Blender four point three."
# make update
# make
# cd ..
# cd ..

# # Get system memory total
# Kilobytes_ram=$(grep MemTotal /proc/meminfo | awk '{print $2}')
# Megabytes_ram=$((Kilobytes_ram/1000))

# determined_lto="poop"
# if [ "$Megabytes_ram" -lt 4000 ]; then
# 	determined_lto="none"
# elif [ "$Megabytes_ram" -lt 8000 ]; then
# 	determined_lto="thin"
# else
# 	determined_lto="full"
# fi

cd git

# Get logic core count
cpu_cores=$(nproc)
halfcores=$((cpu_cores / 2))

espeak "Compiling [[gV]]dough" &
# Get start time
godot_start_time=$(date +%s) &
echo "Starting script at: $(date -d @$godot_start_time)"

cd godot
scons platform=linuxbsd optimize=debug -j$halfcores
cd ..
# Get end time
godot_end_time=$(date +%s)


espeak "Compiling Inkscape" &
# Get start time
inkscape_start_time=$(date +%s) &
echo "Starting script at: $(date -d @$inkscape_start_time)"

cd inkscape
mkdir build
cd build
cmake -S .. -B . -DCMAKE_INSTALL_PREFIX=${PWD}/install_dir -DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache
make -j2
make install
cd ..
cd ..
# Get end time
inkscape_end_time=$(date +%s)



godot_elapsed_time=$((godot_end_time - godot_start_time))
echo "Godotcompiled in $(date -d $)


inkscape_elapsed_time=$((inkscape_end_time - inkscape_start_time))

# Log the times
echo "Script started at: $(date -d @$start_time)"
echo "Script ended at: $(date -d @$end_time)"
echo "Elapsed time: $elapsed_time seconds"

espeak "Benchmark complete!" &

# Wait
read -p "Press Enter to exit..."
