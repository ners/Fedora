#!/bin/sh

SRC_IMAGE=$(mktemp /tmp/i3lock_XXXXXX.jpg)
DST_IMAGE=$(mktemp /tmp/i3lock_XXXXXX.png)
USR_SRC=/var/lib/AccountsService/icons/$USER
USR_DST=/tmp/i3user.png
USR_SIZE=150
USR_X=$(xrandr | grep primary | cut -d' ' -f4 | awk -F '[x+]' "{print \$1/2+\$3-$USR_SIZE/2}")
USR_Y=$(xrandr | grep primary | cut -d' ' -f4 | awk -F '[x+]' "{print \$2/2+\$4-$USR_SIZE/2}")
USR_GEO="${USR_SIZE}x${USR_SIZE}+${USR_X}+${USR_Y}"

if [ ! -f "$USR_DST" ]; then
	convert $USR_SRC -resize "1000x1000" $USR_DST
	convert -size "1000x1000" xc:none -fill $USR_DST -draw "circle 500,500 500,1" -resize "${USR_SIZE}x${USR_SIZE}" $USR_DST
fi

# Take a screenshot
scrot $SRC_IMAGE
# Pixellate it 20x
convert $SRC_IMAGE -scale 5% -scale 2000% $DST_IMAGE
## Overlay avatar in the centre
#convert $DST_IMAGE $USR_DST -geometry $USR_GEO -composite $DST_IMAGE
# Set it as screensaver
i3lock -i $DST_IMAGE -e -u
rm -f /tmp/i3lock_*.{jpg,png}
# Rerun blank i3lock if it is not running
pgrep i3lock || i3lock

# Turn the screen off after a delay if it is still locked
sleep 1800
pgrep i3lock && xset dpms force off
