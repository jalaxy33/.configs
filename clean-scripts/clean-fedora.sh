# clean dnf cache and remove unused packages
sudo dnf clean all
sudo dnf autoremove

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


