Fedora setup
============

# Update the system
If using the latest version:
```sh
sudo dnf upgrade --refresh -y
source /etc/os-release
VERSION=33
if [ "$VERSION_ID" -lt $VERSION ] ; then
    sudo dnf install -y dnf-plugin-system-upgrade
    sudo dnf system-upgrade -y download --releasever=$VERSION
    sudo dnf system-upgrade -y reboot
fi
```

# Install basic tools
```sh
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y boxes curl dnf-plugins-core direnv entr expect fuse-exfat fuse-sshfs git git-credential-libsecret httpie jq make moreutils the_silver_searcher util-linux-user vim wget
```
## Optional GUI tools:
```sh
sudo dnf install -y geary gnome-tweaks mpv telegram-desktop transmission-gtk transmission-remote-gtk vim-X11 yaru-theme clipq
```

## Optional nVidia driver:
⚠️ Warning: the official nVidia driver is terrible for system stability. Expect your battery life to suffer and future updates to break your system. Try to avoid the driver if you can, and next time you buy a computer, nVidia as a whole.
```sh
sudo dnf install -y gcc kernel-headers kernel-devel akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-libs xorg-x11-drv-nvidia-libs.i686
sleep 60
sudo akmods --force
sudo dracut --force
sudo cp home/-p /usr/share/X11/xorg.conf.d/nvidia.conf /etc/X11/xorg.conf.d/nvidia.conf
sudo sed -i 's|EndSection|\tOption "PrimaryGPU" "yes"\nEndSection|' /etc/X11/xorg.conf.d/nvidia.conf
```

# Change shell to ZSH
```sh
sudo dnf install -y zsh zsh-syntax-highlighting
git clone https://github.com/sindresorhus/pure.git /tmp/pure
sudo cp /tmp/pure/async.zsh /usr/share/zsh/site-functions/async
sudo cp /tmp/pure/pure.zsh /usr/share/zsh/site-functions/prompt_pure_setup
chsh -s $(which zsh)
for f in .zshrc .zshrc.local .profile ; do cp home/$f ~/$f ; done
```

# Install Haskell
```sh
curl -sSL https://get.haskellstack.org/ | sh
```

# Install Docker
Do not use Docker. Use Podman instead. It comes preinstalled with Fedora Workstation.

# Set up Git
```sh
for f in .gitconfig .gitignore ; do cp home/$f ~/$f ; done
```

# Set up Vim
```sh
sudo dnf install -y yarnpkg libicu-devel ncurses-devel zlib-devel
mkdir -p ~/.vim/ftplugin ~/.vim/pack/vendor/start

cd ~/.vim/pack/vendor/start
plugins=(
chriskempson/base16-vim
preservim/nerdtree
neoclide/coc.nvim
neovimhaskell/haskell-vim
cohama/lexima.vim
ryanoasis/vim-devicons
tiagofumo/vim-nerdtree-syntax-highlight
)
for p in ${plugins[@]}; do git clone --depth 1 "https://github.com/$p.git"; done

vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q
yarn --cwd coc.nvim
git clone https://github.com/haskell/haskell-language-server.git /tmp/haskell-language-server
cd /tmp/haskell-language-server
stack install.hs hls-8.8.3
find .vim -type f | while read f ; do cp home/$f ~/$f ; done
```

## Optional VS Code:
```sh
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install code
```

# Change WM to i3
```sh
sudo dnf install -y lightdm lightdm-gtk-greeter-settings
sudo systemctl disable gdm
sudo systemctl enable lightdm

sudo dnf install -y blueman compton i3 i3lock ImageMagick network-manager-applet scrot @xfce-desktop-environment ulauncher
```
