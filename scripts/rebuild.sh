#!/usr/bin/env bash

OTHER_ARGS=()
I_ARGS=()
HOSTNAME=""

while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--hostname)
      HOSTNAME="$2"
      shift
      shift
      ;;
    *)
      OTHER_ARGS+=("$1")
      shift
      ;;
  esac
done

if [ -n "$HOSTNAME" ]; then
    REPO_PATH="/etc/nixos"
    MACHINE_PATH="$REPO_PATH/machines/$HOSTNAME"
    I_ARGS+=("-I" "nixpkgs=$REPO_PATH/modules/nixpkgs")
    I_ARGS+=("-I" "nixos-config=$MACHINE_PATH/configuration.nix")
fi

echo nixos-rebuild "${I_ARGS[@]}" "${OTHER_ARGS[@]}"
exec nixos-rebuild "${I_ARGS[@]}" "${OTHER_ARGS[@]}"
