# Debian

Not tested. The commands below were looked up on 31 October 2026 in Debian's package index. They were not run.

Debian 13 (trixie):

- `lutris` 0.5.19-2 is in **contrib**. The tested install used Lutris 0.5.22.
- `wine` is in main.
- `python3-protobuf` is the protobuf package. It is a Recommends of the lutris package. Arch calls the same library `python-protobuf`.
- `umu-launcher` is not in the Debian package tracker, so the command does not include it. On the Arch test, Lutris used `umu-launcher`. Whether the Debian package downloads its own copy was not checked.

Enable the contrib component, then:

```bash
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install lutris wine python3-protobuf
lutris lutris:install/battlenet-standard
```

The `i386` line is there because the 32-bit NVIDIA library is an i386 package.

Proprietary NVIDIA is in **non-free**. The looked-up library package is `nvidia-driver-libs:i386` (550.163.01-2 on trixie). Not run:

```bash
sudo apt install nvidia-driver-libs:i386
```

Then follow [Install DXVK first](../README.md#install-dxvk-first). Those Lutris steps were run on Arch.
