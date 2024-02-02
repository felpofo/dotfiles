#!/bin/sh

if [ "$(id -u)" -eq 0 ]; then
  echo "do not run as sudo" &> /dev/stderr
  exit 1
fi

core="base-devel man-db man-pages texinfo git reflector openssl openssh mesa make cmake ninja hdparm gtk2 gtk3 gtk4 dconf dconf-editor gparted dhcp dhcpcd"
apps="alacritty tmux fish chromium firefox telegram-desktop qbittorrent onlyoffice-bin obs-studio inkscape discord"
dev="neovim vim clang gcc gdb rustup go zig python lua luajit nim jdk-openjdk jdk8-openjdk nasm wget curl sed jq xxd valgrind sqlite raylib sdl2 imagemagick github-cli android-tools"
fonts="ttf-cascadia-code ttf-jetbrains-mono ttf-opensans ttf-ubunti-font-family ttc-iosevka ttf-iosevka-nerd"
tools="eza bat ripgrep nnn btop pastel nmap ncdu fzf"
media="pipewire pipewire-alsa pipewire-audio pipewire-pulse wireplumber easyeffects pavucontrol alsa-utils playerctl mpd mpc ncmpcpp cantata spotify mpv flac ffmpeg audacity"
files="tar bzip2 gzip xz zstd zip unzip"
others="seahorse scrcpy xdg-desktop-portal xdg-desktop-portal-gtk polkit polkit-gnome"
xorg="bspwm sxhkd maim rofi feh dunst xclip xorg-xinit xorg-xrandr xorg-xinput xorg-xev xorg-setxkbmap xorg-xprop xorg-xset xorg-xsetroot xorg-xmodmap xdo"
#TODO: wayland="hyprland"
aur="boomer-git mpd-mpris-bin soundux spicetify-cli prismlauncher-qt5-bin catppuccin-gtk-theme-macchiato betterdiscordctl aseprite ani-cli-git"

sudo pacman -Syu --needed $core $apps $dev $fonts $tools $media $files $others

rustup toolchain install stable
rustup toolchain install nightly
rustup default nightly

pushd /tmp
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si
popd

paru -Syu $aur

pushd /tmp
git clone https://git.sr.ht/~nasmevka/bspad
cd bspad
sed -ie 's/bspad/void.sh/g' bspad
cp bspad ~/.local/bin/void.sh
popd
