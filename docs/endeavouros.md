# EndeavourOS

Not tested. October 2026 testing was Arch Linux only.

EndeavourOS uses the same `pacman` commands as Arch. The 32-bit NVIDIA packages need the multilib repository.

```bash
sudo pacman -S lutris wine umu-launcher python-protobuf
sudo pacman -S nvidia-utils lib32-nvidia-utils vulkan-icd-loader lib32-vulkan-icd-loader
lutris lutris:install/battlenet-standard
```

The second command is for the proprietary NVIDIA driver.

After the packages are installed, follow [Install DXVK first](../README.md#install-dxvk-first). Those steps were run on Arch, not on EndeavourOS.
