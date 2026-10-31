# Fedora

Not tested. The commands below were looked up on 31 October 2026 in Fedora's package index and on RPM Fusion's NVIDIA howto. They were not run.

- Fedora 43, 44, and 45 list `lutris` 0.5.22. The tested install used Lutris 0.5.22.
- `wine` is in the Fedora repositories.
- `python3-protobuf` is a dependency of the Fedora 45 lutris package. Arch calls the same library `python-protobuf`.
- Fedora's package index has no `umu-launcher` page, so the command does not include it. On the Arch test, Lutris used `umu-launcher`. Whether the Fedora package downloads its own copy was not checked.

```bash
sudo dnf install lutris wine python3-protobuf
lutris lutris:install/battlenet-standard
```

Proprietary NVIDIA is not in Fedora's own repositories. [RPM Fusion's NVIDIA howto](https://rpmfusion.org/Howto/NVIDIA) says current GeForce cards (2017 and later) use `akmod-nvidia` from the RPM Fusion nonfree repository, and that current Fedora pulls the 32-bit library `xorg-x11-drv-nvidia-libs.i686` with it. Enable that third-party repository first. The repository-enable command is on RPM Fusion's configuration page and is not copied here. Not run:

```bash
sudo dnf install akmod-nvidia
```

Then follow [Install DXVK first](../README.md#install-dxvk-first). Those Lutris steps were run on Arch.
