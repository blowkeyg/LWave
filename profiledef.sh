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
