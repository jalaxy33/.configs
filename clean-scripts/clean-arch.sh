# use paccache to remove software cache
# should install pacman-contrib first: sudo pacman -S pacman-contrib
sudo paccache -rk 1   # keep the last version of each package
sudo paccache -ruk0   # remove cache of old and uninstalled packages

# clean by pacman
sudo pacman -Sc  # clean old and unused packages

# search for orphaned packages
sudo pacman -Qtdq  # search
sudo pacman -Rns $(pacman -Qtdq)  # remove them

# limit journal size
sudo journalctl --vacuum-size=50M

# clear specific journal logs
sudo truncate -s 0 /var/log/syslog

# clear homebrew
brew autoremove
brew cleanup --prune all

# remove cache and temp files
rm -rf ~/.cache/*
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

