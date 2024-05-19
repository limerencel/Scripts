#!/bin/bash

show_menu() {
  echo "Now I'm gonna delete the venvs, please select your venv manager: "
  echo "1) Poetry"
  echo "2) Pipenv"
}


deletFiles() {
  local MANAGER=$1
  read -p "Are you sure want to delete the $MANAGER cache? (y/n, default y): " confirm
      if [[ "${confirm:-y}" == [yY] ]]; then
        if [[ $MANAGER == "poetry" ]]; then
          DIR="/users/$USER/Library/Caches/pypoetry/virtualenvs/*"
        elif [[ $MANAGER == "pipenv" ]]; then
          DIR="/Users/$USER/.local/share/virtualenvs/*"
        else
          echo "Invaild name"
          return 1
        fi

        if [[ -n "$ZSH_VERSION" ]]; then
          setopt rm_star_silent
        fi
        rm -rf $DIR
        if [[ -n "$ZSH_VERSION" ]]; then
          unsetopt rm_star_silent
        fi
        echo "Deleted successfully"
      else
        echo "Operation cancelled"
      fi
}

show_menu
read -p "Enter your choice [1-2]: " choice

case $choice in
  1)
    deletFiles "poetry"
    ;;
  2)
    deletFiles "pipenv"
    ;;
  *)
    echo "Invalid choice. Please enter a number between 1-2"

esac