# Pop!_OS

Not tested. The `apt` names below were looked up on 31 October 2026 on Ubuntu's package pages. They were not checked against Pop!_OS's own package list, and they were not run.

Pop!_OS is Ubuntu-based. System76's install notes say the Ubuntu archives are where extra `.deb` packages come from.

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

Pop!_OS documents its own proprietary NVIDIA package. Looked up on System76's install page, not run:

```bash
sudo apt install system76-driver-nvidia
```

That page did not name a 32-bit library, so none is listed here.

Then follow [Install DXVK first](../README.md#install-dxvk-first). Those Lutris steps were run on Arch.
