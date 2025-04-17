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

and regenerate boot options:
```
sudo reinstall kernels
```

Now set the theme:

```bash
yay -S --noconfirm plymouth-theme-endeavouros
```

# KDE configuration

- Global theme: Ant-dark
- Colors: Breeze Dark
- Application Style: Breeze
- Window decoration: Large icon size
- Icons: Papirus Dark
- Splash screen: Kuro the cat

# Launchers setup

```bash
yay -S --noconfirm steam lutris heroic-games-launcher wine winetrics lib32-gnutls
```

# Yakuake setup

- Color theme: bl1nk
- Font: Hack 14pt

# Other software

```bash
yay -S --noconfirm baobab discord dropbox vlc git visual-studio-code-bin yakuake python-pip python gitkraken veracrypt python-pygments
```
