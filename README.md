Fedora setup
============

# Update the system
If you're on a decent connection, speed up DNF updates:
```sh
echo max_parallel_downloads=16 | sudo tee -a /etc/dnf/dnf.conf
```
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
sudo dnf install -y aria2 boxes curl dnf-plugins-core direnv entr expect fuse-exfat fuse-sshfs git git-credential-libsecret httpie jq make moreutils the_silver_searcher util-linux-user neovim wget
```
## Optional GUI tools:
```sh
sudo dnf install -y kitty geary gnome-tweaks mpv novim-qt telegram-desktop transmission-gtk transmission-remote-gtk yaru-theme
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

## Install HLS for IDE integration
```sh
git clone https://github.com/haskell/haskell-language-server.git /tmp/haskell-language-server
cd /tmp/haskell-language-server
stack install.hs hls-8.8.4
```

# Install Docker
Do not use Docker. Use Podman instead. It comes preinstalled with Fedora Workstation.

# Set up Git
```sh
for f in .gitconfig .gitignore ; do cp home/$f ~/$f ; done
```

# Set up Neovim
```sh
cp -r home/.config/nvim ~/.config/nvim

sudo dnf install -y yarnpkg libicu-devel ncurses-devel zlib-devel
mkdir -p ~/.local/share/nvim/site/pack/github/start
mkdir -p ~/.vim/ftplugin ~/.vim/pack/vendor/start

cd ~/.local/share/nvim/site/pack/github/start
plugins=(
chriskempson/base16-vim
cohama/lexima.vim
neoclide/coc.nvim
neovimhaskell/haskell-vim
preservim/nerdtree
ryanoasis/vim-devicons
sbdchd/neoformat
tiagofumo/vim-nerdtree-syntax-highlight
)
for p in ${plugins[@]}; do git clone --depth 1 "https://github.com/$p.git"; done

yarn --cwd coc.nvim
sudo wget -O /usr/share/fonts/roboto-mono-nerd.ttf "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/RobotoMono/Regular/complete/Roboto Mono Nerd Font Complete.ttf"
sudo fc-cache -fv
```

## Optionally install VS Code:
```sh
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install code
```

# Change WM to Sway
```sh
sudo dnf install sway swaylock swayidle waybar grim slurp wl-clipboard python3-i3ipc
sudo wget -O /usr/bin/grimshot https://raw.githubusercontent.com/swaywm/sway/master/contrib/grimshot
sudo chmod +x /usr/bin/grimshot
cp -r home/.config/sway home/.config/waybar ~/.config
```

## Optionally install Inter font
```sh
mkdir /tmp/inter
cd /tmp/inter
wget -q https://github.com/rsms/inter/releases/download/v3.15/Inter-3.15.zip
unzip Inter-*.zip
sudo mv Inter\ Desktop /usr/local/fonts/inter-desktop
sudo fc-cache -fv
```

# Install Wine
```sh
sudo dnf install -y wine winetricks
sudo winetricks --self-update
```

## Optionally speed up winetricks downloads:
```sh
sudo sed -i 's|torify} aria2c|& -x16 -s16 |' /usr/bin/winetricks
```
