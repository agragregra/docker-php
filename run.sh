#!/bin/bash

# Set error handling
set -e  # Exit on error

# Configuration variables
output_dir="www/"
deploy_server="user@server.com:path/to/public_html/"
rsync_options="-avz --delete --delete-excluded --exclude=.env.local --include=*.htaccess"
backup_compression_options="-t7z -mx=9 -m0=LZMA2 -mmt=on"
backup_date_format="+%d-%m-%Y"

# Function to get directory name
get_dir_name() {
  basename "$(pwd)"
}

# Function to get current date (cross-platform)
get_current_date() {
  date $backup_date_format
}

# Function to check dependencies
check_deps() {
  local deps=($@)
  local missing=()

  for dep in "${deps[@]}"; do
    command -v "$dep" >/dev/null 2>&1 || missing+=("$dep")
  done

  if [ ${#missing[@]} -ne 0 ]; then
    echo "${missing[*]} is not installed"
    exit 1
  fi
}

# Function to remove mysql socket if it exists
remove_mysql_socket() {
  if [ -L "$(pwd)/data/mysql.sock" ]; then
    sudo rm "$(pwd)/data/mysql.sock"
  fi
}

up() {
  remove_mysql_socket
  check_deps "docker-compose"
  sudo chmod -R 777 .
  docker-compose up -d
}

down() {
  remove_mysql_socket
  check_deps "docker-compose"
  docker-compose down
}

bash() {
  check_deps "docker-compose"
  docker-compose exec web bash
}

prune() {
  check_deps "docker"
  docker system prune -af --volumes
}

deploy() {
  check_deps "rsync"
  echo "Running: rsync $rsync_options $output_dir $deploy_server"
  rsync $rsync_options $output_dir $deploy_server
}

backup() {
  check_deps "7z"
  local dir_name=$(get_dir_name)
  local current_date=$(get_current_date)
  remove_mysql_socket
  sudo chmod -R 777 .
  sudo 7z a $backup_compression_options -x!$dir_name/node_modules ./$dir_name-$current_date.7z $(pwd)
}

clear() {
  remove_mysql_socket
  sudo chmod -R 777 .
}

# Handle arguments
main() {
  case $1 in
    "up")     up     ;;
    "down")   down   ;;
    "bash")   bash   ;;
    "prune")  prune  ;;
    "deploy") deploy ;;
    "backup") backup ;;
    "clear")  clear  ;;
    *)
      echo "Usage: $0 { up | down | bash | prune | deploy | backup | clear }"
      exit 1
      ;;
  esac
}

main $@
