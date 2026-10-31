# Linux Mint

Not tested. The commands below were looked up on 31 October 2026 on Ubuntu's package pages. They were not checked against Linux Mint's own package list, and they were not run.

Linux Mint is Ubuntu-based and installs packages with `apt`. The names below are the Ubuntu names.

- `lutris` is in Ubuntu **multiverse**: 0.5.14-2 on Ubuntu 24.04, 0.5.22-1 on Ubuntu 26.04. The tested install used Lutris 0.5.22.
- `wine` is in Ubuntu **universe**.
- `python3-protobuf` is the protobuf package. Arch calls the same library `python-protobuf`.
- A search of every Ubuntu suite for `umu-launcher` returned no package, so the command does not include it.

Enable multiverse and universe if they are not already enabled, then:

```bash
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install lutris wine python3-protobuf
lutris lutris:install/battlenet-standard
```

The Ubuntu 32-bit proprietary NVIDIA library is `libnvidia-gl-<branch>:i386` in **restricted**. Match the branch already installed. No branch is filled in here. Not run.

Then follow [Install DXVK first](../README.md#install-dxvk-first). Those Lutris steps were run on Arch.
