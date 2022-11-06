# My system config

This repo tracks my adventures in the reproducible world of nix.

If you are looking trying to get some inspiration for your config, make sure to checkout these:
- https://github.com/dmarcoux/dotfiles-nixos
- https://github.com/DAlperin/dotfiles
- https://github.com/gvolpe/nix-config
- https://github.com/talyz/nixos-config

Other sources that I used:
- https://mt-caret.github.io/blog/posts/2020-06-29-optin-state.html#fn3

## Install on a new machine

This will clone the whole repo with all submodules (needed).
```
git clone --recurse-submodules git@gitlab.com:JanKaifer/nixos.git
```

Link this repo to `/etc/nixos`:
```
sudo mv /etc/nixos/ /etc/nixos-old
sudo mkdir /etc/nixos
sudo ln -s /home/pearman/Projects/nixos /etc/nixos
```

Before first build you need to choose the correct configuration.nix file:
```
sudo /etc/nixos/scripts/rebuild.sh --hostname "pearframe" switch
```

## Usefull tips

To apply configuration use:
```
sudo /etc/nixos/scripts/rebuild.sh switch
```