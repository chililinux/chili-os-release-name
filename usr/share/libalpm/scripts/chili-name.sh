!/usr/bin/env bash
# -*- coding: utf-8 -*-
# shellcheck shell=bash disable=SC1091,SC2039,SC2166
#
#  /usr/share/libalpm/scripts/chili-name.sh
#  Created: 2024/11/05 - 22:17
#  Altered: 2024/11/05 - 22:17
#
#  Copyright (c) 2024-2024, Vilmar Catafesta <vcatafesta@gmail.com>
#  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions
#  are met:
#  1. Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#  2. Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR AS IS'' AND ANY EXPRESS OR
#  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
#  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
#  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
#  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
#  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
#  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
#  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
#  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
##############################################################################
conf_file='/etc/issue'
sed -i 's|^Manjaro Linux|Chili Linux, based on LFS|g' "$conf_file"
sed -i 's|^BigLinux, based in Manjaro Linux|Chili Linux, based on LFS|g' "$conf_file"

conf_file='/usr/lib/os-release'
sed -i 's|^ *\bNAME\b *=.*|NAME="Chili Linux based on LFS"|' "$conf_file"
sed -i 's|^ *\bPRETTY_NAME\b *=.*|PRETTY_NAME="ChiliLinux based on LFS"|' "$conf_file"
sed -i 's|^ *\bHOME_URL\b *=.*|HOME_URL="https://chililinux.com"|' "$conf_file"
sed -i 's|^ *\bDOCUMENTATION_URL\b *=.*||' "$conf_file"
sed -i 's|^ *\bSUPPORT_URL\b *=.*|SUPPORT_URL="https://t.me/chililinux"|' "$conf_file"
sed -i 's|^ *\LOGO\b *=.*|LOGO="chililinux-menu"|' "$conf_file"
sed -i 's|^ *\ID\b *=.*|ID="chililinux"|' "$conf_file"
sed -i 's|^ *\bBUG_REPORT_URL\b *=.*|BUG_REPORT_URL="https://github.com/chililinux"|' "$conf_file"
sed -i 's|^ *\bPRIVACY_POLICY_URL=.*||' "$conf_file"

[[ -e "$conf_file" ]] && rm -f /etc/os-release
[[ -e "$conf_file" ]] && ln -sf "$conf_file" /etc/os-release

# Configuração adicional para corrigir inserções indesejadas no GRUB
conf_file='/etc/default/grub'
sed -i 's|^GRUB_THEME=.*|GRUB_THEME="/boot/grub/themes/chili/theme.txt"|' "$conf_file"
sed -i 's|^GRUB_DISTRIBUTOR=.*|GRUB_DISTRIBUTOR="Chili"|' "$conf_file"

# Atualiza a configuração do GRUB, caso o comando exista
if command -v update-grub &>/dev/null; then
	update-grub
elif command -v grub-mkconfig &>/dev/null; then
	grub-mkconfig -o /boot/grub/grub.cfg
fi
