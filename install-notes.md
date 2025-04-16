# Fan control

```bash
yay --noconfirm -S coolercontrol

sudo modprobe nct6775
sudo sensors-detect --auto

sudo systemctl enable coolercontrold
sudo systemctl restart coolercontrold
```

# system LEDs

```bash
yay -S openrgb
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
yay -S --noconfirm baobab discord dropbox vlc git visual-studio-code-bin yakuake
```
