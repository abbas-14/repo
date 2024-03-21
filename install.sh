#!/bin/bash

get_rc_path() {
    if echo "$SHELL" | grep -qP ".*zsh"; then
        # it means current shell is zsh
        echo "$HOME/.zshrc"
    elif echo "$SHELL" | grep -qP ".*bash"; then
        # it means current shell is zsh
        echo "$HOME/.bashrc"
    fi
}

make_install() {
  local files=(repo*)
  if ! [ ${#files[@]} -eq 0 ]; then
    echo "Installing all repo* files into /usr/bin .."
    if ls /usr/bin/repo* 2>/dev/null 1>&2; then
      echo
      echo "Found previous installation."
      echo "Removing previous installed files first.."
      sudo rm /usr/bin/repo*
    fi
    echo
    echo "Total files to be installed: ${#files[@]}"
    for f in "${files[@]}"; do 
      chmod +x "$f"
      echo "copying: $f"
      sudo ln -sf "$(pwd)"/$f /usr/bin/$f 
    done
  else
    echo "Installation failed!"
    echo "reason: current directory does not contain the repo-* files."
  fi
}

install_repo() {
    # install the repo binary
    local REPO_PATH="$2"
    
    if ! [ -d "$REPO_PATH" ]; then
        mkdir -p "$REPO_PATH"
    fi

    cd "$REPO_PATH"

    git clone https://github.com/abbas-14/repo.git
    if ! [ $? -eq 0 ]; then
        echo "cannot clone a git repository: abbas-14/repo"
        exit 1
    fi
    cd repo
    make_install
}

main() {
    local REPO_PATH="$HOME/.local/lib"
    
    if ! [ -d "$REPO_PATH/repo" ]; then
        install_repo "$REPO_PATH"
    else
        echo "[d] repo already installed."
    fi
    
}

main "$@"