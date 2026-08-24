#!/bin/bash
# LWave OS Repository Configuration Setup Utility

echo "🌊 Creating directory tree paths..."
mkdir -p airootfs/usr/local/bin

echo "📝 Creating profiledef.sh text configuration file..."
cat << 'EOF' > profiledef.sh
#!/usr/bin/env bash
iso_name="lwave"
iso_label="WAVELINUX_$(date +%Y%m)"
iso_publisher="LWave Community Core"
iso_application="LWave Standalone Installation Media"
iso_version="v1.0.0"
bootmodes=('bios.syslinux.mbr' 'uefi-x86_64.grub.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_comp="zstd"
airootfs_options=("-Xcompression-level" "22")
file_permissions=(
  ["/usr/local/bin/lwave-installer.sh"]="0:0:755"
)
EOF

echo "🛒 Creating packages.x86_64 software text package file..."
cat << 'EOF' > packages.x86_64
linux linux-firmware systemd xorg-server xorg-xinit python flatpak ttf-jetbrains-mono
openbox polybar plank rofi pipewire pipewire-pulse wireplumber mesa
vulkan-intel xf86-video-intel vulkan-radeon xf86-video-amdgpu nvidia nvidia-utils nvidia-prime
EOF

echo "🎮 Creating lwave-installer.sh core script block..."
cat << 'EOF' > airootfs/usr/local/bin/lwave-installer.sh
#!/bin/bash
CHOSEN_DRIVERS=$(rofi -dmenu -multi-select -p "🎮 Select Your Graphics Hardware" <<EOF
Intel GPU Drivers
AMD Radeon GPU Drivers
NVIDIA Proprietary Driver Hook
Bluetooth Hardware Firmware Pack
EOF
)
CHOSEN_APPS=$(rofi -dmenu -multi-select -p "📦 Select Apps to Pre-install" <<EOF
Firefox (Web Browser)
Sidra (Apple Music)
Spotify (Music Streaming)
Discord (Chat App)
Steam (Gaming Hub)
EOF
)
for DRIVER in $CHOSEN_DRIVERS; do
    case "$DRIVER" in
        "Intel GPU Drivers") pacman -S --noconfirm xf86-video-intel vulkan-intel ;;
        "AMD Radeon GPU Drivers") pacman -S --noconfirm xf86-video-amdgpu vulkan-radeon ;;
        "NVIDIA Proprietary Driver Hook") pacman -S --noconfirm nvidia nvidia-utils nvidia-prime ;;
        "Bluetooth Hardware Firmware Pack") pacman -S --noconfirm bluez bluez-utils && systemctl enable bluetooth.service ;;
    esac
done
for APP in $CHOSEN_APPS; do
    case "$APP" in
        "Firefox (Web Browser)") flatpak install -y flathub org.mozilla.firefox ;;
        "Sidra (Apple Music)") flatpak install -y flathub io.github.wimpysworld.Sidra ;;
        "Spotify (Music Streaming)") flatpak install -y flathub com.spotify.Client ;;
        "Discord (Chat App)") flatpak install -y flathub com.discordapp.Discord ;;
        "Steam (Gaming Hub)") flatpak install -y flathub com.valvesoftware.Steam ;;
    esac
done
cat <<EOF > /etc/systemd/logind.conf
[Login]
HandleLidSwitch=suspend
HandleLidSwitchExternalPower=suspend
HandleLidSwitchDocked=ignore
LidSwitchIgnoreInhibited=yes
EOF
AUTOSTART_PATH="/etc/skel/.config/openbox/autostart"
mkdir -p "$(dirname "$AUTOSTART_PATH")"
cat <<EOF >> "$AUTOSTART_PATH"
python3 /usr/local/bin/beachdream-monitor.py &
python3 -m http.server --directory /tmp/beachdream_status 8000 &
EOF
TARGET_DRIVE=$(lsblk -dno NAME,TYPE | awk '$2=="disk" {print "/dev/"$1}' | grep -v "$(lsblk -no PKNAME $(df / | awk 'NR==2 {print $1}'))" | head -n 1)
if [ -z "$TARGET_DRIVE" ]; then
    rofi -e "❌ Error: No target hard drive found to install LWave OS!"
    exit 1
fi
rofi -e "🚀 Target Found: $TARGET_DRIVE\nWarning: This will format the disk. Copying LWave OS now..."
echo -e "label: gpt\n, , L" | sfdisk "$TARGET_DRIVE"
TARGET_PART="${TARGET_DRIVE}1"
if [[ "$TARGET_DRIVE" == *"nvme"* ]]; then
    TARGET_PART="${TARGET_DRIVE}p1"
fi
mkfs.ext4 -F "$TARGET_PART"
mkdir -p /mnt/lwave_target
mount "$TARGET_PART" /mnt/lwave_target
rsync -aAXv --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found} / /mnt/lwave_target/
umount /mnt/lwave_target
rofi -e "🎉 LWave OS successfully written to your computer disk! Pull out your USB and reboot."
EOF

echo "🔒 Enforcing executable runtime parameters..."
chmod +x airootfs/usr/local/bin/lwave-installer.sh

echo "✨ LWave structural setup file creation complete!"
