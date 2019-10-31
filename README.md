Fedora setup
============

# Change shell to ZSH

```
sudo dnf install -y git util-linux-user zsh zsh-syntax-highlighting
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
chsh -s $(which zsh)
```

# Change WM to i3

```
sudo dnf install -y lightdm lightdm-gtk-greeter-settings
sudo systemctl disable gdm
sudo systemctl enable lightdm

sudo dnf install -y @xfce-desktop-environment i3 i3lock
curl -s https://api.github.com/repos/Ulauncher/Ulauncher/releases/latest \
	| jq -r '.assets[].browser_download_url' \
	| grep rpm \
	| tail -n1 \
	| wget -O /tmp/ulauncher.rpm -i -
sudo dnf install /tmp/ulauncher.rpm
```
