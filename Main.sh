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
Sidra (Apple Music)
Spotify (Music Streaming)
Discord (Chat App)
Steam (Gaming Hub)
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
        "Sidra (Apple Music)")
            flatpak install -y flathub io.github.wimpysworld.Sidra ;;
        "Spotify (Music Streaming)")
            flatpak install -y flathub com.spotify.Client ;;
        "Discord (Chat App)")
            flatpak install -y flathub com.discordapp.Discord ;;
        "Steam (Gaming Hub)")
            flatpak install -y flathub com.valvesoftware.Steam ;;
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
# FIXED: Replaced string typo with clean shell bracket directory expansion
AUTOSTART_PATH="/etc/skel/.config/openbox/autostart"
mkdir -p "$(dirname "$AUTOSTART_PATH")"

cat <<EOF >> "$AUTOSTART_PATH"

# Run local web server telemetry scripts
python3 /usr/local/bin/beachdream-web-monitor.py &
python3 -m http.server --directory /tmp/beachdream_status 8000 &
EOF

# --- 8. FINALIZE IMMUTABLE CLONING ACTION ---
rofi -e "🚀 Customizations mapped! Copying LWave to your hard drive and locking the immutable core..."

# Execution commands to push image to bare metal hard drive go here...
chmod +x ~/Lwave/airootfs/usr/local/bin/lwave-installer.sh


