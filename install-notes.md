# Fan control

```bash
yay --noconfirm -S coolercontrol

sudo modprobe nct6775
sudo sensors-detect --auto

sudo systemctl enable coolercontrold
sudo systemctl restart coolercontrold
```

And create **/etc/modules-load.d/nct6775.conf**:

```
# Load nct6775.ko at boot
nct6775
```

# manual swapfile creation (potential fix for black screen on login)

```bash
mkswap -U clear --size 8G --file /swapfile
swapon /swapfile
```

then add to **/etc/fstab**

```
/swapfile none swap defaults 0 0
```

# system LEDs

```bash
yay -S openrgb
```

# Plymouth (also hints about changing kernel options)

systemd-boot entries are located in **/efi/loader/entries**

Install plymouth:

```bash
yay -S --noconfirm plymouth
```

add plymouth to dracut by creating **/etc/dracut.conf.d/plymouth.conf**

```
add_dracutmodules+=" plymouth "
```

Edit kernel command line in /etc/kernel/cmdline and append

```
... splash
```

Now set the theme and rebuild initramfs:

```bash
yay -S --noconfirm plymouth-theme-arch-os
sudo plymouth-set-default-theme -R arch-os
sudo reinstall-kernels # regenerate boot options and update initramfs
```

# KDE configuration

- Global theme: Ant-dark
- Colors: Breeze Dark
- Application Style: Breeze
- Window decoration: Large icon size
- Icons: Papirus Dark
- Splash screen: Kuro the cat

# nvidia

[Source](https://linuxiac.com/nvidia-with-wayland-on-arch-setup-guide/)

**/etc/dracut.conf.d/nvidia.conf**

```
omit_dracutmodules+=" kms "
force_drivers+=" nvidia nvidia_modeset nvidia_uvm nvidia_drm "
```

**/etc/modules-load.d/nvidia.conf**

```
nvidia nvidia_modeset nvidia_uvm nvidia_drm
```

**/etc/kernel/cmdline**

```
... nvidia_drm.modeset=1 nvidia_drm.fbdev=1 nvidia.NVreg_EnableGpuFirmware=0 ...
```

**/etc/environment**

```
...
GBM_BACKEND=nvidia-drm
__GLX_VENDOR_LIBRARY_NAME=nvidia
```

```bash
nvidia-inst # reinstall nvidia drivers via endeavour os script
sudo reinstall-kernels
```

# disable amd drivers (integrated GPU)

**/etc/dracut.conf.d/blacklist-amd.conf**

```
omit_dracutmodules+=" amdgpu "
```

# Launchers setup

```bash
yay -S --noconfirm steam lutris heroic-games-launcher wine winetrics lib32-gnutls
```

# Yakuake setup

- Color theme: bl1nk
- Font: Hack 14pt

# Other software

```bash
yay -S --noconfirm baobab discord dropbox vlc git visual-studio-code-bin yakuake python-pip python gitkraken veracrypt python-pygments gameconqueror jq
```

# disable kdewalled

**~/.config/kwalletrc**

```
[Wallet]
First Use=false
Enabled=false
```

# Troubleshooting from a live usb

When booter in live usb (root has no password for eos live usb), open a terminal and mount your / partition somewhere, then:

```bash
arch-chroot /path/to/your/mountpoint
```

# Unresolved issues

## Soundblaster X3

This one seems to cause freezes when login manager starts (no kayboard, no display)
Replacing it with a X4 seems to workaround the issue for now.