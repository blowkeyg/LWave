# 🌊 LWave OS

**A privacy-first, zero-bloat, immutable Linux distribution** built for speed, security, and human happiness.

LWave OS is powered by **Archcraft** and combines the clean, modern interface of Windows 11 with the freedom, privacy, and control of Linux—without the corporate greed.

---

## 🎯 Core Philosophy

Tech monopolies build software to make shareholders and data brokers happy.  
**LWave OS is built to make the human behind the keyboard happy.**

### The Three Pillars

#### 1. **🚫 The War Against Corporate Bloatware**
- Beautiful, modern Windows 11-style interface without the garbage
- Zero pre-installed corporate apps, forced games, or unwanted assistants
- Clean, minimal system—your CPU stays cold and quiet
- Only the tools YOU choose to install

#### 2. **🔒 Zero Tracking, Zero Spying**
- 100% offline, private, and local-first
- Absolutely zero telemetry or data collection
- No mandatory cloud logins or registration
- Kernel-level network shielding blocks data brokers before they touch your network card

#### 3. **⚡ Unbreakable Immutable Design**
- Read-only filesystem architecture makes the OS virtually un-brickable
- All applications run safely in sandboxed Flatpak bubbles
- One bad command can't destroy your system
- Simple reboot = instant factory-reset to pristine "beach sunset" theme

---

## ✨ Key Features

| Feature | Benefit |
|---------|---------|
| **Archcraft Integration** | Modern, elegant openbox window manager with hand-crafted themes |
| **Windows 11-Style Wave Menu** | Familiar interface for users switching from Windows |
| **~200MB RAM Idle Footprint** | Ultra-lightweight, snappy performance on any hardware |
| **Immutable Filesystem** | System can't be broken by user mistakes |
| **Flatpak Sandboxing** | All apps run isolated—safer, more secure |
| **Driver Selection on Boot** | Choose Intel/AMD/NVIDIA drivers during installation |
| **Custom App Store** | Pre-select Firefox, Spotify, Discord, Steam, Sidra, etc. |
| **100% Free & Open Source** | GPL-3.0 licensed, no corporate lock-in or reselling |

---

## 💻 Minimum Requirements

### For Building LWave OS (Compiling the ISO)

| Requirement | Specification |
|-------------|---|
| **Operating System** | Linux (Arch Linux recommended) |
| **CPU Architecture** | x86_64 (64-bit) |
| **RAM** | 4GB minimum, 8GB+ recommended |
| **Disk Space** | 15-20GB free (for build workspace + ISO output) |
| **Internet** | Required for downloading packages from Arch/Archcraft repos |
| **Build Tools** | `archiso`, `mkarchiso`, `rsync`, `pacman`, `git`, `base-devel` |

**Build Time**: ~15-30 minutes (varies by internet speed and CPU)

### LWave OS Live ISO

| Specification | Value |
|---|---|
| **ISO File Size** | ~700-850MB (zstd compressed, level 22) |
| **Uncompressed Size** | ~2.5-3GB |
| **Media Required** | USB 3.0 drive, 1GB+ minimum (2GB+ recommended) |
| **Download Time** | ~5-15 minutes (depends on connection speed) |

### For Installing LWave OS (End Users)

| Requirement | Minimum | Recommended |
|---|---|---|
| **CPU** | 64-bit dual-core | Quad-core or better |
| **RAM** | 2GB (live boot) | 4GB or more |
| **Disk Space** | 10GB (bare OS only) | 15-20GB (with apps) |
| **Boot Method** | UEFI or BIOS | UEFI preferred |
| **Network** | Optional (offline install works) | Recommended for Flatpak apps |
| **GPU** | Integrated graphics | Intel/AMD/NVIDIA supported |

### Hardware Support & Drivers

LWave OS detects and offers installation of:

| Hardware | Support | Drivers Available |
|---|---|---|
| **Intel iGPU** | ✅ Full | `xf86-video-intel`, `vulkan-intel` |
| **AMD Radeon** | ✅ Full | `xf86-video-amdgpu`, `vulkan-radeon` |
| **NVIDIA GPU** | ✅ Full | `nvidia`, `nvidia-utils`, `nvidia-prime` |
| **Bluetooth** | ✅ Supported | `bluez`, `bluez-utils` |
| **WiFi/Ethernet** | ✅ Auto-detected | Arch Linux built-in drivers |
| **USB Peripherals** | ✅ Full | Standard Linux HID support |

---

## 🚀 Quick Start

### Prerequisites
- Linux system with `mkarchiso`, `rsync`, `pacman`
- 4GB+ RAM for building
- 15GB+ free disk space
- Internet connection

### Build LWave OS ISO

1. **Clone the repository**
   ```bash
   git clone https://github.com/blowkeyg/LWave.git
   cd LWave
   ```

2. **Run the automated setup script**
   ```bash
   chmod +x setup_lwave.sh
   ./setup_lwave.sh
   ```
   This generates:
   - `pacman.conf` — Custom package manager config with Archcraft repos
   - `profiledef.sh` — ISO build configuration
   - `packages.x86_64` — Core system packages + Archcraft themes
   - `airootfs/usr/local/bin/lwave-installer.sh` — Interactive installer

3. **Compile the ISO**
   ```bash
   mkarchiso -v -w /tmp/archiso-tmp -o /tmp/lwave-output ./
   ```

4. **Your ISO is ready!**
   ```bash
   ls -lh /tmp/lwave-output/lwave-*.iso
   ```

---

## 🔄 Automated CI/CD Pipeline

LWave OS uses **GitHub Actions** to automate compilation, testing, and releases.

### Workflow: `.github/workflows/build-lwave-iso.yml`

Every push to `main` automatically:
- ✅ Installs Arch Linux + Archcraft dependencies
- ✅ Generates build configuration
- ✅ Compiles the ISO with maximum compression (zstd level 22)
- ✅ Scans for security issues & validates shell syntax
- ✅ Generates SHA256 checksums
- ✅ Creates GitHub Release with ISO artifacts
- ✅ Retains build logs for 30 days

**Trigger manually:**
```
GitHub → Actions → Build LWave OS ISO → Run workflow
```

**Download compiled ISOs:**
- View at: `github.com/blowkeyg/LWave/actions`
- Artifacts tab → `lwave-os-iso`
- Or grab from Releases page

---

## 💾 Installation Process

When you boot the LWave ISO:

1. **🎮 Select Graphics Hardware**
   ```
   ☐ Intel GPU Drivers
   ☐ AMD Radeon GPU Drivers
   ☐ NVIDIA Proprietary Drivers
   ☐ Bluetooth Hardware Firmware
   ```

2. **📦 Choose Pre-installed Apps**
   ```
   ☐ Firefox (Web Browser)
   ☐ Sidra (Apple Music)
   ☐ Spotify (Music Streaming)
   ☐ Discord (Chat)
   ☐ Steam (Gaming)
   ```

3. **🚀 Auto-detect Target Drive & Deploy**
   - Automatic disk detection (excludes current system)
   - GPT partition table with ext4 filesystem
   - Full system copy via `rsync`
   - Reboot into your new LWave OS

---

## 📁 Project Structure

```
LWave/
├── setup_lwave.sh              # Automated build system generator
├── profiledef.sh               # ISO build configuration (generated)
├── pacman.conf                 # Arch package manager config (generated)
├── packages.x86_64             # Core system packages list (generated)
├── airootfs/                   # Live ISO root filesystem
│   └── usr/local/bin/
│       └── lwave-installer.sh  # Interactive installer script
├── .github/workflows/
│   └── build-lwave-iso.yml     # GitHub Actions CI/CD pipeline
└── README.md                   # This file
```

---

## 🔐 Privacy & Security

✅ **Zero Telemetry** — No data collection, tracking, or profiling  
✅ **No Cloud Lock-in** — Everything works offline, locally  
✅ **No Forced Updates** — You control when/if to update  
✅ **Open Source** — Fully transparent, community-auditable code  
✅ **Sandboxed Apps** — Flatpak isolation prevents unauthorized access  
✅ **Immutable Core** — System can't be compromised by malicious scripts  

---

## 🤝 Contributing

Found a bug? Have a feature idea? Want to improve LWave OS?

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/amazing-thing`)
3. **Commit your changes** (`git commit -m 'Add amazing thing'`)
4. **Push to your fork** (`git push origin feature/amazing-thing`)
5. **Open a Pull Request** on the main repository

---

## 📄 License

LWave OS is released under the **GNU General Public License v3.0** (GPL-3.0).

This means:
- ✅ Free to use, modify, and distribute
- ✅ Source code must remain open
- ✅ No corporate reselling or proprietary lock-in

Read the full license: [LICENSE](LICENSE)

---

## 🙏 Credits & Acknowledgments

- **Archcraft** — Beautiful openbox themes, icons, and configurations
- **Arch Linux** — Solid, minimal, rolling-release foundation
- **The Linux Community** — For building the freedom we all deserve

---

## 📞 Support & Community

- **Issues** — Report bugs at: https://github.com/blowkeyg/LWave/issues
- **Discussions** — Ask questions: https://github.com/blowkeyg/LWave/discussions
- **Actions** — Monitor builds: https://github.com/blowkeyg/LWave/actions

---

## 🌊 The LWave Promise

Every time you boot LWave OS, you're choosing:
- **Privacy over profit**
- **Simplicity over bloat**
- **Control over convenience**
- **Freedom over corporate greed**

Welcome to the wave. 🌊✨
