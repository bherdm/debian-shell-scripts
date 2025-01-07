#! /usr/bin/bash
#chmod u+x hello_debian.sh

# Iterate through each item in the base directory
for dir in ~/git/*; do
  echo $dir
  # Check if the item is a directory
  if [ -d "$dir" ]; then
    # Change to the directory
    cd "$dir"
    # Check if it's a Git repository
    if [ -d ".git" ]; then
      echo "Cleaning Git repository: $dir"
      git clean -dfx
      git reset --hard
    else
      echo "Not a Git repository: $dir"
    fi
  fi
done

read -p "Press Enter to exit..."