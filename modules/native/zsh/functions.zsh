# modules/native/zsh/functions.zsh

function pyenv {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo "Deactivating virtual environment: $(basename "$VIRTUAL_ENV")"
    deactivate
  else
    if [ ! -d "./venv" ]; then
      echo "No venv found. Creating one with $(python --version)..."
      python -m venv venv
    fi
    echo "Activating venv..."
    source ./venv/bin/activate
  fi
}

function nswitch {
  local starting_dir=$(pwd)
  local config_dir="$HOME/NixOS-Config"
  local host=$(hostname)

  if [ ! -d "$config_dir" ]; then
    echo "Error: Configuration directory '$config_dir' not found."
    return 1
  fi

  cd "$config_dir" || return

  echo "Building NixOS for host: $host..."
  if sudo nixos-rebuild switch --flake ".#$host"; then
    echo "----------------------------------------------------"
    echo "SUCCESS: System updated."
    
    if ! git diff --quiet HEAD || [ -n "$(git status --short)" ]; then
      local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
      git add .
      git commit -m "rebuild: $timestamp"
    fi

    echo -n "Would you like to push these changes to GitHub? (y/N): "
    read -r response
    
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
      echo "Pushing to remote..."
      git pull --rebase origin main
      git push origin main 
    else
      echo "Push skipped. Changes remain in your local Git history."
    fi
  else
    local exit_code=$?
    echo "----------------------------------------------------"
    echo "ERROR: NixOS switch FAILED with exit code $exit_code."
    cd "$starting_dir"
    return $exit_code
  fi

  cd "$starting_dir"
}

function nflup {
  local config_dir="$HOME/NixOS-Config"
  local starting_dir=$(pwd)

  if [ ! -d "$config_dir" ]; then
    echo "Error: Configuration directory '$config_dir' not found."
    return 1
  fi

  cd "$config_dir" || return

  echo "Updating Nix flake lockfile..."
  if nix flake update; then
    echo "----------------------------------------------------"
    echo "SUCCESS: flake.lock updated."
    
    echo -n "Would you like to rebuild and switch now? (y/N): "
    read -r response
    
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
      nswitch
    else
      echo "Update complete. Remember to commit and switch later."
    fi
  else
    echo "ERROR: Failed to update flake."
    cd "$starting_dir"
    return 1
  fi

  cd "$starting_dir"
}

function nup {
  local config_dir="$HOME/NixOS-Config"
  local starting_dir=$(pwd)

  if [ ! -d "$config_dir" ]; then
    echo "Error: Configuration directory '$config_dir' not found."
    return 1
  fi

  PAGER=cat builtin cd "$config_dir" || return

  echo "Checking for remote changes on GitHub..."
  PAGER=cat git fetch origin main --quiet

  local LOCAL_HASH=$(git rev-parse HEAD)
  local REMOTE_HASH=$(git rev-parse @{u})

  if [ "$LOCAL_HASH" != "$REMOTE_HASH" ]; then
    echo "Changes detected (Remote: ${REMOTE_HASH:0:7}). Pulling..."

    if PAGER=cat git pull origin main --rebase --quiet; then
      echo "Successfully updated local files from GitHub."
      echo "----------------------------------------------------"
      PAGER=cat nswitch
    else
      echo "ERROR: Conflict detected during pull. Please resolve manually."
      builtin cd "$starting_dir"
      return 1
    fi
  else
    echo "Local config is already up to date with GitHub."
    echo -n "Would you like to run nswitch anyway? (y/N): "
    read -r "response? "
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
      PAGER=cat nswitch
    fi
  fi

  builtin cd "$starting_dir"
}

function nsearch {
  echo "--- Packages ---"
  nix-env -qaP "$1" | grep -i "$1"
  echo ""
  echo "--- Options ---"
  man nixos-rebuild | grep -i "$1" 
}

function try {
  nix-shell -p "$@" --run zsh
}

function nerr() {
  journalctl -u nixos-rebuild --since "10 minutes ago" | grep -iE "error|failed"
}

function nvidia-run {
  export __NV_PRIME_RENDER_OFFLOAD=1
  export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
  export __GLX_VENDOR_LIBRARY_NAME=nvidia
  export __VK_LAYER_NV_optimus=NVIDIA_only
  exec "$@"
}
