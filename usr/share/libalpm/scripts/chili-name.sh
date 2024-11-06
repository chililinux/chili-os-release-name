#!/usr/bin/env bash

sed -i 's|^Manjaro Linux|Chili Linux, based on LFS|g' /etc/issue
sed -i 's|^BigLinux, based in Manjaro Linux|Chili Linux, based on LFS|g' /etc/issue
sed -i 's|^ *\bNAME\b *=.*|NAME="ChiliLinux based on LFS"|' /usr/lib/os-release
sed -i 's|^ *\bPRETTY_NAME\b *=.*|PRETTY_NAME="ChiliLinux based on LFS"|' /usr/lib/os-release
sed -i 's|^ *\bHOME_URL\b *=.*|HOME_URL="https://chililinux.com"|' /usr/lib/os-release
sed -i 's|^ *\bDOCUMENTATION_URL\b *=.*||' /usr/lib/os-release
sed -i 's|^ *\bSUPPORT_URL\b *=.*|SUPPORT_URL="https://t.me/chililinux"|' /usr/lib/os-release
sed -i 's|^ *\LOGO\b *=.*|LOGO="chililinux-menu"|' /usr/lib/os-release
sed -i 's|^ *\ID\b *=.*|ID="chililinux"|' /usr/lib/os-release
sed -i 's|^ *\bBUG_REPORT_URL\b *=.*|BUG_REPORT_URL="https://github.com/chililinux"|' /usr/lib/os-release
sed -i 's|^ *\bPRIVACY_POLICY_URL=.*||' /usr/lib/os-release

[[ -e /usr/lib/os-release ]] && cp -f /usr/lib/os-release /etc/os-release

# Configuração adicional para corrigir inserções indesejadas no GRUB
sed -i 's|^GRUB_THEME=.*|GRUB_THEME="/boot/grub/themes/chili/theme.txt"|' /etc/default/grub
sed -i 's|^GRUB_DISTRIBUTOR=.*|GRUB_DISTRIBUTOR="Chili"|' /etc/default/grub

# Atualiza a configuração do GRUB, caso o comando exista
if command -v update-grub &>/dev/null; then
	update-grub
elif command -v grub-mkconfig &>/dev/null; then
	grub-mkconfig -o /boot/grub/grub.cfg
fi
