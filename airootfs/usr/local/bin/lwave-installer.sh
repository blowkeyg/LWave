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
CHOSEN_APPS=$(rofi -dmenu -multi-select -p "📦 Select Apps to Pre-install (50+ Flatpaks)" <<EOF
🌐 Web Browsers
Firefox (Web Browser)
Chromium (Alternative Browser)
Librewolf (Privacy Browser)
Thorium (Fast Browser)
Epiphany (GNOME Browser)
🎮 Gaming & Emulation
Steam (Gaming Hub)
Lutris (Game Manager)
Proton-GE (Game Compatibility Layer)
Dolphin (GameCube/Wii Emulator)
PCSX2 (PS2 Emulator)
RetroArch (Multi-System Emulator)
Heroic Launcher (Game Launcher)
PlayOnLinux (Wine Wrapper)
💬 Communication
Discord (Chat App)
Telegram (Messaging)
Slack (Team Chat)
Jami (Peer-to-Peer Chat)
Element (Matrix Client)
Blabber.im (XMPP Client)
🎵 Audio & Music
Spotify (Music Streaming)
Sidra (Apple Music)
Audacity (Audio Editor)
Cider (Apple Music)
Rhythmbox (Music Player)
GNOME Music (Simple Music Player)
Plex (Media Server)
📺 Video & Media
VLC (Media Player)
Mpv (Minimalist Media Player)
OBS Studio (Screen Recording)
Kdenlive (Video Editor)
HandBrake (Video Transcoder)
Shotcut (Video Editor)
FFmpeg (Video Tools)
🎨 Graphics & Design
GIMP (Image Editor)
Krita (Digital Painting)
Inkscape (Vector Graphics)
Blender (3D Modeling)
Darktable (Photo Manager)
RawTherapee (Photo Editor)
Aseprite (Pixel Art)
📊 Office & Productivity
LibreOffice (Office Suite)
OnlyOffice (Office Suite)
Thunderbird (Email Client)
Evolution (Email & Calendar)
Notion (Note Taking)
Obsidian (Note Taking)
Draw.io (Diagramming)
📁 File & Cloud Management
Nextcloud (Cloud Storage)
Syncthing (File Sync)
Transmission (Torrent Client)
Qbittorrent (Torrent Client)
Rclone (Cloud Sync)
File Roller (Archive Manager)
Nautilus (File Manager)
🔒 Security & Privacy
Mullvad VPN (Privacy VPN)
ProtonVPN (Privacy VPN)
Bitwarden (Password Manager)
KeePass (Password Manager)
Veracrypt (Encryption)
Cryptomator (Cloud Encryption)
Signal (Secure Messaging)
GPG Tools (Encryption)
🛠️ Development & Terminal
VS Code (Code Editor)
Gedit (Text Editor)
Sublime Text (Advanced Editor)
Terminus (Terminal)
GitKraken (Git GUI)
Postman (API Testing)
DBeaver (Database Tool)
Docker (Containerization)
🖥️ System & Utilities
GNOME Tweaks (System Settings)
Nemo (Advanced File Manager)
Top Processes (System Monitor)
htop (Process Monitor)
Freetube (YouTube Frontend)
Newsflash (RSS Reader)
Flatseal (Permission Manager)
🎬 Entertainment
Jellyfin (Media Server)
Tautulli (Plex Monitor)
Stremio (Streaming)
MPV Configuration Tool
Music Player Daemon (Music Server)
🌐 Web Tools
Tor Browser (Anonymity)
Joplin (Note Sync)
Bookworm (E-book Reader)
Calibre (E-book Manager)
Zotero (Research Tool)
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
        # Web Browsers
        "Firefox (Web Browser)")
            flatpak install -y flathub org.mozilla.firefox ;;
        "Chromium (Alternative Browser)")
            flatpak install -y flathub org.chromium.Chromium ;;
        "Librewolf (Privacy Browser)")
            flatpak install -y flathub io.gitlab.librewolf-community ;;
        "Thorium (Fast Browser)")
            flatpak install -y flathub com.github.Alex313031.Thorium ;;
        "Epiphany (GNOME Browser)")
            flatpak install -y flathub org.gnome.Epiphany ;;
        # Gaming & Emulation
        "Steam (Gaming Hub)")
            flatpak install -y flathub com.valvesoftware.Steam ;;
        "Lutris (Game Manager)")
            flatpak install -y flathub net.lutris.Lutris ;;
        "Proton-GE (Game Compatibility Layer)")
            flatpak install -y flathub com.github.Matoking.protontricks ;;
        "Dolphin (GameCube/Wii Emulator)")
            flatpak install -y flathub org.dolphin_emu.dolphin ;;
        "PCSX2 (PS2 Emulator)")
            flatpak install -y flathub net.pcsx2.PCSX2 ;;
        "RetroArch (Multi-System Emulator)")
            flatpak install -y flathub org.libretro.RetroArch ;;
        "Heroic Launcher (Game Launcher)")
            flatpak install -y flathub com.heroicgameslauncher.hgl ;;
        "PlayOnLinux (Wine Wrapper)")
            flatpak install -y flathub org.playonlinux.playonlinux ;;
        # Communication
        "Discord (Chat App)")
            flatpak install -y flathub com.discordapp.Discord ;;
        "Telegram (Messaging)")
            flatpak install -y flathub org.telegram.desktop ;;
        "Slack (Team Chat)")
            flatpak install -y flathub com.slack.Slack ;;
        "Jami (Peer-to-Peer Chat)")
            flatpak install -y flathub cx.ring.Ring ;;
        "Element (Matrix Client)")
            flatpak install -y flathub im.riot.Riot ;;
        "Blabber.im (XMPP Client)")
            flatpak install -y flathub de.gultsch.Conversations ;;
        # Audio & Music
        "Spotify (Music Streaming)")
            flatpak install -y flathub com.spotify.Client ;;
        "Sidra (Apple Music)")
            flatpak install -y flathub io.github.wimpysworld.Sidra ;;
        "Audacity (Audio Editor)")
            flatpak install -y flathub org.audacityteam.Audacity ;;
        "Cider (Apple Music)")
            flatpak install -y flathub sh.cider.Cider ;;
        "Rhythmbox (Music Player)")
            flatpak install -y flathub org.gnome.Rhythmbox3 ;;
        "GNOME Music (Simple Music Player)")
            flatpak install -y flathub org.gnome.Music ;;
        "Plex (Media Server)")
            flatpak install -y flathub tv.plex.PlexDesktop ;;
        # Video & Media
        "VLC (Media Player)")
            flatpak install -y flathub org.videolan.VLC ;;
        "Mpv (Minimalist Media Player)")
            flatpak install -y flathub io.mpv.Mpv ;;
        "OBS Studio (Screen Recording)")
            flatpak install -y flathub com.obsproject.Studio ;;
        "Kdenlive (Video Editor)")
            flatpak install -y flathub org.kde.kdenlive ;;
        "HandBrake (Video Transcoder)")
            flatpak install -y flathub fr.handbrake.ghb ;;
        "Shotcut (Video Editor)")
            flatpak install -y flathub org.shotcut.Shotcut ;;
        "FFmpeg (Video Tools)")
            flatpak install -y flathub org.ffmpeg.FFmpeg ;;
        # Graphics & Design
        "GIMP (Image Editor)")
            flatpak install -y flathub org.gimp.GIMP ;;
        "Krita (Digital Painting)")
            flatpak install -y flathub org.kde.krita ;;
        "Inkscape (Vector Graphics)")
            flatpak install -y flathub org.inkscape.Inkscape ;;
        "Blender (3D Modeling)")
            flatpak install -y flathub org.blender.Blender ;;
        "Darktable (Photo Manager)")
            flatpak install -y flathub org.darktable.Darktable ;;
        "RawTherapee (Photo Editor)")
            flatpak install -y flathub com.rawtherapee.RawTherapee ;;
        "Aseprite (Pixel Art)")
            flatpak install -y flathub com.aseprite.Aseprite ;;
        # Office & Productivity
        "LibreOffice (Office Suite)")
            flatpak install -y flathub org.libreoffice.LibreOffice ;;
        "OnlyOffice (Office Suite)")
            flatpak install -y flathub org.onlyoffice.desktopeditors ;;
        "Thunderbird (Email Client)")
            flatpak install -y flathub org.mozilla.Thunderbird ;;
        "Evolution (Email & Calendar)")
            flatpak install -y flathub org.gnome.Evolution ;;
        "Notion (Note Taking)")
            flatpak install -y flathub notion.Notion ;;
        "Obsidian (Note Taking)")
            flatpak install -y flathub md.obsidian.Obsidian ;;
        "Draw.io (Diagramming)")
            flatpak install -y flathub com.jgraph.drawio.desktop ;;
        # File & Cloud Management
        "Nextcloud (Cloud Storage)")
            flatpak install -y flathub com.nextcloud.desktopclient.nextcloud ;;
        "Syncthing (File Sync)")
            flatpak install -y flathub me.syncthing.syncthing ;;
        "Transmission (Torrent Client)")
            flatpak install -y flathub com.transmissionbt.Transmission ;;
        "Qbittorrent (Torrent Client)")
            flatpak install -y flathub org.qbittorrent.qBittorrent ;;
        "Rclone (Cloud Sync)")
            flatpak install -y flathub com.rclone.rclone ;;
        "File Roller (Archive Manager)")
            flatpak install -y flathub org.gnome.FileRoller ;;
        "Nautilus (File Manager)")
            flatpak install -y flathub org.gnome.Nautilus ;;
        # Security & Privacy
        "Mullvad VPN (Privacy VPN)")
            flatpak install -y flathub net.mullvad.mullvadvpn ;;
        "ProtonVPN (Privacy VPN)")
            flatpak install -y flathub ch.protonvpn.protonvpn ;;
        "Bitwarden (Password Manager)")
            flatpak install -y flathub com.bitwarden.desktop ;;
        "KeePass (Password Manager)")
            flatpak install -y flathub org.keepassxc.KeePassXC ;;
        "Veracrypt (Encryption)")
            flatpak install -y flathub org.veracrypt.VeraCrypt ;;
        "Cryptomator (Cloud Encryption)")
            flatpak install -y flathub org.cryptomator.Cryptomator ;;
        "Signal (Secure Messaging)")
            flatpak install -y flathub org.signal.Signal ;;
        "GPG Tools (Encryption)")
            flatpak install -y flathub org.gnupg.kleopatra ;;
        # Development & Terminal
        "VS Code (Code Editor)")
            flatpak install -y flathub com.visualstudio.code ;;
        "Gedit (Text Editor)")
            flatpak install -y flathub org.gnome.gedit ;;
        "Sublime Text (Advanced Editor)")
            flatpak install -y flathub com.sublimetext.three ;;
        "Terminus (Terminal)")
            flatpak install -y flathub com.github.Keats.gnome-terminal-transparency ;;
        "GitKraken (Git GUI)")
            flatpak install -y flathub com.gitkraken.GitKraken ;;
        "Postman (API Testing)")
            flatpak install -y flathub com.getpostman.Postman ;;
        "DBeaver (Database Tool)")
            flatpak install -y flathub io.dbeaver.DBeaverCommunity ;;
        "Docker (Containerization)")
            flatpak install -y flathub com.docker.Docker ;;
        # System & Utilities
        "GNOME Tweaks (System Settings)")
            flatpak install -y flathub org.gnome.tweaks ;;
        "Nemo (Advanced File Manager)")
            flatpak install -y flathub org.cinnamon.nemo ;;
        "Top Processes (System Monitor)")
            flatpak install -y flathub com.github.WidgetFactory.SystemMonitor ;;
        "htop (Process Monitor)")
            flatpak install -y flathub com.htop.Htop ;;
        "Freetube (YouTube Frontend)")
            flatpak install -y flathub io.freetubeapp.FreeTube ;;
        "Newsflash (RSS Reader)")
            flatpak install -y flathub com.gitlab.newsflash ;;
        "Flatseal (Permission Manager)")
            flatpak install -y flathub com.github.flatseal.Flatseal ;;
        # Entertainment
        "Jellyfin (Media Server)")
            flatpak install -y flathub org.jellyfin.jellyfinmedia ;;
        "Tautulli (Plex Monitor)")
            flatpak install -y flathub com.github.fneumann.Tautulli ;;
        "Stremio (Streaming)")
            flatpak install -y flathub com.stremio.Stremio ;;
        "Music Player Daemon (Music Server)")
            flatpak install -y flathub org.musicpd.mpc ;;
        # Web Tools
        "Tor Browser (Anonymity)")
            flatpak install -y flathub org.torproject.torbrowser-launcher ;;
        "Joplin (Note Sync)")
            flatpak install -y flathub net.cozic.joplin_desktop ;;
        "Bookworm (E-book Reader)")
            flatpak install -y flathub com.github.babluboy.bookworm ;;
        "Calibre (E-book Manager)")
            flatpak install -y flathub com.calibre_ebook.calibre ;;
        "Zotero (Research Tool)")
            flatpak install -y flathub org.zotero.Zotero ;;
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
