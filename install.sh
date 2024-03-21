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

install_repo() {
    # install the repo binary
    local REPO_PATH="$2"
    
    if ! [ -d "$REPO_PATH" ]; then
        mkdir -p "$REPO_PATH"
    fi

    cd "$REPO_PATH"

    gitty clone https://github.com/abbas-14/repo.git
    cd repo
    sudo make install
}

relocate_git() {
    type git 1>/dev/null 2>&1

    if [ $? -eq 0 ]; then
        local GIT_PATH_CURR=$(which git | sed 's/git//')
        sudo mv "$GIT_PATH_CURR/git" "$GIT_PATH_CURR/gitty"
    else
        echo "error: no git installation found."
        echo
        echo "Please install git first and run this script again!"
    fi
}

main() {
    local REPO_PATH="$HOME/.local/lib"

    if ! type gitty 1>/dev/null 2>&1; then
        relocate_git
    else
        echo "[d] git already relocated."
    fi
    
    if ! [ -d "$REPO_PATH/repo" ]; then
        install_repo "$REPO_PATH"
    else
        echo "[d] repo already installed."
    fi
    
}

main "$@"