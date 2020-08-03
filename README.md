Fedora setup
============

# Update the system
If using the latest version:
```sh
sudo dnf upgrade -y
```
If using an older version:
```sh
sudo dnf upgrade --refresh -y
sudo dnf install dnf-plugin-system-upgrade
sudo dnf system-upgrade download --releasever=32
```

# Install basic tools
```sh
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y curl dnf-plugins-core entr expect fuse-exfat fuse-sshfs git httpie jq make moreutils the_silver_searcher util-linux-user vim wget
```
Optional GUI tools:
```sh
sudo dnf install -y geary mpv telegram-desktop transmission-gtk vim-X11
```

# Change shell to ZSH
```sh
sudo dnf install -y zsh zsh-syntax-highlighting
git clone https://github.com/sindresorhus/pure.git /tmp/pure
sudo cp /tmp/pure/async.zsh /usr/share/zsh/site-functions/async
sudo cp /tmp/pure/pure.zsh /usr/share/zsh/site-functions/prompt_pure_setup
wget -O ~/.zshrc https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
cat << EOF > ~/.zshrc.local
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.profile
PURE_CMD_MAX_EXEC_TIME=1
PURE_PROMPT_SYMBOL=‣
autoload -U promptinit; promptinit
prompt pure
EOF
touch ~/.profile
chsh -s $(which zsh)
```

# Change WM to i3
```sh
sudo dnf install -y lightdm lightdm-gtk-greeter-settings
sudo systemctl disable gdm
sudo systemctl enable lightdm

sudo dnf install -y blueman compton i3 i3lock ImageMagick network-manager-applet scrot @xfce-desktop-environment
curl -s https://api.github.com/repos/Ulauncher/Ulauncher/releases/latest \
	| jq -r '.assets[].browser_download_url' \
	| grep rpm \
	| tail -n1 \
	| wget -O /tmp/ulauncher.rpm -i -
sudo dnf install /tmp/ulauncher.rpm
```

# Install Haskell
```sh
sudo dnf copr enable -y petersen/stack
sudo dnf install -y haskell-platform stack
```

# Install Docker
Do not use Docker. Use Podman instead. It is preinstalled with Fedora Workstation.
