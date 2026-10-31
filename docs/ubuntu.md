# Ubuntu

Not tested. The commands below were looked up on 31 October 2026 on Ubuntu's package pages. They were not run.

- `lutris` is in **multiverse**: 0.5.14-2 on Ubuntu 24.04 (noble), 0.5.22-1 on Ubuntu 26.04 (resolute). The tested install used Lutris 0.5.22.
- `wine` is in **universe**.
- `python3-protobuf` is the protobuf package. It is a Recommends of the lutris package. Arch calls the same library `python-protobuf`.
- A search of every Ubuntu suite for `umu-launcher` returned no package, so the command does not include it. On the Arch test, Lutris used `umu-launcher`. Whether the Ubuntu package downloads its own copy was not checked.

Enable multiverse and universe, then:

```bash
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install lutris wine python3-protobuf
lutris lutris:install/battlenet-standard
```

The `i386` line is there because the 32-bit NVIDIA library is an i386 package.

The 32-bit proprietary NVIDIA library is `libnvidia-gl-<branch>:i386` in **restricted**. Ubuntu 26.04's package pages list several branches, including 580, 590, 595, and 610. Match the branch already installed. No branch is filled in here. Not run.

Then follow [Install DXVK first](../README.md#install-dxvk-first). Those Lutris steps were run on Arch.
