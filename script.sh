#!/bin/bash

# Constants
readonly SUCCESS=0
readonly FAILURE=1

# ANSI color codes
readonly COLOR_RED='\033[0;31m'
readonly COLOR_GREEN='\033[0;32m'
readonly COLOR_YELLOW='\033[0;33m'
readonly COLOR_RESET='\033[0m'

# Function to add or remove files to/from all folders except excluded directories and their subdirectories
function modify_files {
  local dir_path="$1"
  local files_to_modify=("${@:2}")

  # Add or remove files using rm command
  if [[ "$delete_files" == 1 ]]; then
    for file in "${files_to_modify[@]}"; do
      rm -f "$dir_path/$(basename "$file")"
      if [[ "$verbose" == 1 ]]; then
        printf "${COLOR_YELLOW}Removed:${COLOR_RESET} %s/%s\n" "$dir_path" "$(basename "$file")"
      fi
    done
  else
    rsync -a "${files_to_modify[@]}" "$dir_path"
    if [[ "$verbose" == 1 ]]; then
      printf "${COLOR_YELLOW}Added:${COLOR_RESET} %s to %s\n" "${files_to_modify[*]}" "$dir_path"
    fi
  fi
}

# Usage information
function usage {
  printf "Usage: %s [OPTIONS] <ROOT_PATH>\n" "$0"
  printf "Add or remove files to/from a directory and its subdirectories except for excluded directories.\n\n"
  printf "Options:\n"
  printf "  -r, --root          Add or remove files to/from the root directory.\n"
  printf "  -e, --exclude       Exclude a directory and its subdirectories from being modified.\n"
  printf "  -f, --file          Specify a file to add or remove. Can be specified multiple times.\n"
  printf "  -d, --delete        Remove files instead of adding them.\n"
  printf "  -v, --verbose       Verbose mode: show details of each action.\n"
  printf "  -h, --help          Show this help message and exit.\n"
  exit "$1"
}

# Logo
printf "${COLOR_YELLOW}  ___  _            _                  ___ _ _       __  __\n${COLOR_RESET}"
printf "${COLOR_YELLOW} |   \\(_)_ _ ___ __| |_ ___ _ _ _  _  | __(_) |___  |  \\/  |__ _ _ _  __ _ __ _ ___ _ _\n${COLOR_RESET}"
printf "${COLOR_YELLOW} | |) | | '_/ -_) _|  _/ _ \\ '_| || | | _|| | / -_) | |\\/| / _\` | ' \\/ _\` / _\` / -_) '_|\n${COLOR_RESET}"
printf "${COLOR_YELLOW} |___/|_|_| \\___\\__|\\__\\___/_|  \\_, | |_| |_|_\\___| |_|  |_|\\__,_|_||_\\__,_\\__, \\___|_|\n${COLOR_RESET}"
printf "${COLOR_YELLOW}                                |__/                                        |___/\n${COLOR_RESET}"

printf "\n\n"

# Parse command line arguments using getopts
root_path=""
add_to_root=0
delete_files=0
verbose=0
excluded_dirs=()
files_to_modify=()

while getopts "re:f:dhv" opt; do
  case $opt in
  r)
    add_to_root=1
    ;;
  e)
    excluded_dirs+=("$OPTARG")
    ;;
  f)
    files_to_modify+=("$OPTARG")
    ;;
  d)
    delete_files=1
    ;;
  v)
    verbose=1
    ;;
  h)
    usage "$SUCCESS"
    ;;
  *)
    usage "$FAILURE"
    ;;
  esac
done
shift $((OPTIND - 1))

# Check if the root path is a valid directory
if [[ ! -d "$1" ]]; then
  printf "${COLOR_RED}Error:${COLOR_RESET} %s is not a valid directory\n" "$1"
  usage "$FAILURE"
fi
root_path="$1"

# Add or remove files to/from all other folders except excluded directories and their subdirectories
find "$root_path" -mindepth 1 -type d | while read -r folder; do
  # Check if folder should be excluded
  exclude_folder=0

  for excluded_folder in "${excluded_dirs[@]}"; do
    if [[ "$(readlink -f "$folder")" == "$(readlink -f "$root_path/$excluded_folder")"* ]]; then
      exclude_folder=1
      break
    fi
  done

  if [[ "$exclude_folder" == 0 ]]; then
    modify_files "$folder" "${files_to_modify[@]}"
  fi
done

# Add or remove files to/from root directory if add_to_root is set to 1
if [[ "$add_to_root" == 1 ]]; then
  modify_files "$root_path" "${files_to_modify[@]}"
fi

printf "\n\n"

# Check if the rm command was successful
if [[ "$delete_files" == 1 ]]; then
  if [[ $? -eq 0 ]]; then
    printf "${COLOR_GREEN}Success:${COLOR_RESET} Files removed from %s\n" "$root_path"
  else
    printf "${COLOR_RED}Failed:${COLOR_RESET} An error occurred while removing files from %s\n" "$root_path"
    exit "$FAILURE"
  fi
else
  printf "${COLOR_GREEN}Success:${COLOR_RESET} Files added to %s\n" "$root_path"
fi

printf "\n"