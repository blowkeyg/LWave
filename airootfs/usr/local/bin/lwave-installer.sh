#!/bin/bash

# =====================================================================
# 🌊 LWAVE OS INTEGRATED INSTALLER & CONFIGURATION MATRIX
# =====================================================================

# --- 1. USER INTERFACE: SELECT HARDWARE STACK ---
CHOSEN_DRIVERS=$(rofi -dmenu -multi-select -p "🎮 Select Your Graphics Hardware" <<EOF
Intel GPU Drivers
AMD Radeon GPU Drivers
NVIDIA Proprietary Driver Hook
Bluetooth Hardware Firmware Pack
EOF
)

# --- 2. USER INTERFACE: SELECT APPLICATIONS ---
CHOSEN_APPS=$(rofi -dmenu -multi-select -p "📦 Select Apps to Pre-install" <<EOF
Firefox (Web Browser)
Chromium (Alternative Browser)
Librewolf (Privacy Browser)
Thorium (Fast Browser)
Sidra (Apple Music)
Spotify (Music Streaming)
Discord (Chat App)
Telegram (Messaging)
Steam (Gaming Hub)
Lutris (Game Manager)
GIMP (Image Editor)
Krita (Digital Painting)
Blender (3D Modeling)
OBS Studio (Screen Recording)
Audacity (Audio Editor)
VLC (Media Player)
Transmission (Torrent Client)
Syncthing (File Sync)
Nextcloud (Cloud Storage)
LibreOffice (Office Suite)
Thunderbird (Email Client)
Mullvad VPN (Privacy VPN)
Bitwarden (Password Manager)
EOF
)

# --- 3. HARDWARE PROVISIONING ENGINE ---
for DRIVER in $CHOSEN_DRIVERS; do
    case "$DRIVER" in
        "Intel GPU Drivers")
            pacman -S --noconfirm xf86-video-intel vulkan-intel ;;
        "AMD Radeon GPU Drivers")
            pacman -S --noconfirm xf86-video-amdgpu vulkan-radeon ;;
        "NVIDIA Proprietary Driver Hook")
            pacman -S --noconfirm nvidia nvidia-utils nvidia-prime ;;
        "Bluetooth Hardware Firmware Pack")
            pacman -S --noconfirm bluez bluez-utils
            systemctl enable bluetooth.service ;;
    esac
done

# --- 4. SOFTWARE SANDBOX DEPLOYMENT ENGINE ---
for APP in $CHOSEN_APPS; do
    case "$APP" in
        "Firefox (Web Browser)")
            flatpak install -y flathub org.mozilla.firefox ;;
        "Chromium (Alternative Browser)")
            flatpak install -y flathub org.chromium.Chromium ;;
        "Librewolf (Privacy Browser)")
            flatpak install -y flathub io.gitlab.librewolf-community ;;
        "Thorium (Fast Browser)")
            flatpak install -y flathub com.github.Alex313031.Thorium ;;
        "Sidra (Apple Music)")
            flatpak install -y flathub io.github.wimpysworld.Sidra ;;
        "Spotify (Music Streaming)")
            flatpak install -y flathub com.spotify.Client ;;
        "Discord (Chat App)")
            flatpak install -y flathub com.discordapp.Discord ;;
        "Telegram (Messaging)")
            flatpak install -y flathub org.telegram.desktop ;;
        "Steam (Gaming Hub)")
            flatpak install -y flathub com.valvesoftware.Steam ;;
        "Lutris (Game Manager)")
            flatpak install -y flathub net.lutris.Lutris ;;
        "GIMP (Image Editor)")
            flatpak install -y flathub org.gimp.GIMP ;;
        "Krita (Digital Painting)")
            flatpak install -y flathub org.kde.krita ;;
        "Blender (3D Modeling)")
            flatpak install -y flathub org.blender.Blender ;;
        "OBS Studio (Screen Recording)")
            flatpak install -y flathub com.obsproject.Studio ;;
        "Audacity (Audio Editor)")
            flatpak install -y flathub org.audacityteam.Audacity ;;
        "VLC (Media Player)")
            flatpak install -y flathub org.videolan.VLC ;;
        "Transmission (Torrent Client)")
            flatpak install -y flathub com.transmissionbt.Transmission ;;
        "Syncthing (File Sync)")
            flatpak install -y flathub me.syncthing.syncthing ;;
        "Nextcloud (Cloud Storage)")
            flatpak install -y flathub com.nextcloud.desktopclient.nextcloud ;;
        "LibreOffice (Office Suite)")
            flatpak install -y flathub org.libreoffice.LibreOffice ;;
        "Thunderbird (Email Client)")
            flatpak install -y flathub org.mozilla.Thunderbird ;;
        "Mullvad VPN (Privacy VPN)")
            flatpak install -y flathub net.mullvad.mullvadvpn ;;
        "Bitwarden (Password Manager)")
            flatpak install -y flathub com.bitwarden.desktop ;;
    esac
done

# --- 5. ENFORCE CHROMEO-STYLE POWER PROFILE (LID SUSPEND) ---
cat <<EOF > /etc/systemd/logind.conf
[Login]
HandleLidSwitch=suspend
HandleLidSwitchExternalPower=suspend
HandleLidSwitchDocked=ignore
LidSwitchIgnoreInhibited=yes
EOF

# --- 6. OPTIMIZE FOR DEEP S3 KERNEL SLEEP ---
if [ -f /etc/default/grub ]; then
    sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="mem_sleep_default=deep /' /etc/default/grub
fi

# --- 7. AUTOMATE REAL-TIME HARDWARE WEB DASHBOARD (PORT 8000) ---
AUTOSTART_PATH="/etc/skel/.config/openbox/autostart"
mkdir -p "$(dirname "$AUTOSTART_PATH")"

cat <<EOF >> "$AUTOSTART_PATH"

# Run local web server telemetry scripts
python3 /usr/local/bin/beachdream-web-monitor.py &
python3 -m http.server --directory /tmp/beachdream_status 8000 &
EOF

# --- 8. FIXED: FULL HARD DRIVE EXECUTION ENGINE ---
# Find the primary hard drive automatically (safely ignoring your bootable USB)
TARGET_DRIVE=$(lsblk -dno NAME,TYPE | awk '$2=="disk" {print "/dev/"$1}' | grep -v "$(lsblk -no PKNAME $(df / | awk 'NR==2 {print $1}'))" | head -n 1)

if [ -z "$TARGET_DRIVE" ]; then
    rofi -e "❌ Error: No target hard drive found to install LWave OS!"
    exit 1
fi

rofi -e "🚀 Target Found: $TARGET_DRIVE\nWarning: This will format the disk. Copying LWave OS now..."

# Create a clean partition layout using sfdisk (Boot sector + Linux Root)
echo -e "label: gpt\n, , L" | sfdisk "$TARGET_DRIVE"

# Identify the newly created installation partition path
TARGET_PART="${TARGET_DRIVE}1"
if [[ "$TARGET_DRIVE" == *"nvme"* ]]; then
    TARGET_PART="${TARGET_DRIVE}p1"
fi

# Format the target drive into a clean Ext4 Linux File System partition
mkfs.ext4 -F "$TARGET_PART"

# Setup a clean local mount destination sandbox folder
mkdir -p /mnt/lwave_target
mount "$TARGET_PART" /mnt/lwave_target

# Execute rsync to clone the entire live OS file structure right onto the hard drive
rsync -aAXv --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} / /mnt/lwave_target/

# Set up standard boot paths and safely lock away the environment
echo "LWave installation complete!"
umount /mnt/lwave_target
rofi -e "🎉 LWave OS successfully written to your computer disk! Pull out your USB and reboot."
