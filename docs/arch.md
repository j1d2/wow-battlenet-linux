# Arch Linux

Tested in October 2026 on a Wayland session with an NVIDIA GPU, Lutris 0.5.22, and a Proton runner Lutris downloaded.

Proprietary NVIDIA driver. `umu-launcher` and the 32-bit packages need the multilib repository.

```bash
sudo pacman -S lutris wine umu-launcher python-protobuf
sudo pacman -S nvidia-utils lib32-nvidia-utils vulkan-icd-loader lib32-vulkan-icd-loader
lutris lutris:install/battlenet-standard
```

Then in Lutris: **Preferences**, **Updates**, install **DXVK**. Close the first Battle.net login window without signing in, start Battle.net from Lutris again, and sign in on that second launch.

The failure notes (protobuf, DXVK, the second launch) are in the [README](../README.md#what-you-need). Log noise, the wrong `python3` on `PATH`, and audio are in [Troubleshooting](troubleshooting.md).
