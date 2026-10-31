# Battle.net and World of Warcraft on Linux

<p align="center">

[![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://github.com/j1d2/wow-battlenet-linux)
[![Lutris](https://img.shields.io/badge/Lutris-FF9900?style=for-the-badge&logo=lutris&logoColor=white)](https://lutris.net)
[![Wine](https://img.shields.io/badge/Wine-800000?style=for-the-badge&logo=wine&logoColor=white)](https://www.winehq.org)
[![Proton](https://img.shields.io/badge/Proton-F50057?style=for-the-badge&logo=proton&logoColor=white)](https://github.com/ValveSoftware/proton)
[![NVIDIA](https://img.shields.io/badge/NVIDIA-76B900?style=for-the-badge&logo=nvidia&logoColor=white)](docs/arch.md)
[![Apache 2.0](https://img.shields.io/badge/Apache_2.0-blue?style=for-the-badge)](LICENSE)

</p>

<p align="center">

[![Arch Linux](https://img.shields.io/badge/Arch_Linux-tested-1793D1?style=flat-square&logo=archlinux&logoColor=white)](docs/arch.md)
[![CachyOS](https://img.shields.io/badge/CachyOS-not_tested-555555?style=flat-square&logo=cachyos&logoColor=white)](docs/cachyos.md)
[![EndeavourOS](https://img.shields.io/badge/EndeavourOS-not_tested-555555?style=flat-square&logo=endeavouros&logoColor=white)](docs/endeavouros.md)
[![Manjaro](https://img.shields.io/badge/Manjaro-not_tested-555555?style=flat-square&logo=manjaro&logoColor=white)](docs/manjaro.md)
[![Debian](https://img.shields.io/badge/Debian-not_tested-555555?style=flat-square&logo=debian&logoColor=white)](docs/debian.md)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-not_tested-555555?style=flat-square&logo=ubuntu&logoColor=white)](docs/ubuntu.md)
[![Linux Mint](https://img.shields.io/badge/Linux_Mint-not_tested-555555?style=flat-square&logo=linuxmint&logoColor=white)](docs/linux-mint.md)
[![Pop!_OS](https://img.shields.io/badge/Pop!__OS-not_tested-555555?style=flat-square&logo=popos&logoColor=white)](docs/pop-os.md)
[![Fedora](https://img.shields.io/badge/Fedora-not_tested-555555?style=flat-square&logo=fedora&logoColor=white)](docs/fedora.md)
[![SteamOS](https://img.shields.io/badge/SteamOS-not_covered-555555?style=flat-square)](docs/steamos.md)
[![Bazzite](https://img.shields.io/badge/Bazzite-not_covered-555555?style=flat-square)](docs/bazzite.md)

</p>

Install the Battle.net launcher with [Lutris](https://lutris.net), then install a World of Warcraft version from inside it.

Tested in October 2026 on Arch Linux, a Wayland session, and an NVIDIA GPU, with Lutris 0.5.22 and a Proton runner Lutris downloaded. The copy-paste block below is that test. Every other distro page is marked not tested.

## TL;DR

Arch Linux. Proprietary NVIDIA driver. Tested October 2026.

```bash
sudo pacman -S lutris wine umu-launcher python-protobuf
sudo pacman -S nvidia-utils lib32-nvidia-utils vulkan-icd-loader lib32-vulkan-icd-loader
lutris lutris:install/battlenet-standard
```

Then in Lutris: **Preferences**, **Updates**, install **DXVK**. Close the first Battle.net login window without signing in, start Battle.net from Lutris again, and sign in on that second launch.

The same `pacman` lines are repeated on the [Arch](docs/arch.md), [CachyOS](docs/cachyos.md), [EndeavourOS](docs/endeavouros.md), and [Manjaro](docs/manjaro.md) pages. Only Arch was tested. There is no `apt` or `dnf` command here until someone has run one.

Blizzard does not support Linux for these games. This is an unofficial player guide. It is not affiliated with, endorsed by, or sponsored by Blizzard Entertainment or Microsoft.

## What you need

Install these from the official Arch repositories:

```bash
sudo pacman -S lutris wine umu-launcher python-protobuf
```

`python-protobuf` is what current Lutris uses for Battle.net. Without it, Lutris logs:

```text
The Battle.net source is unavailable because Google protobuf could not be loaded.
```

On NVIDIA, the 32-bit driver userspace has to match the 64-bit driver (`lib32-nvidia-utils` with `nvidia-utils` on Arch). Also install `vulkan-icd-loader` and `lib32-vulkan-icd-loader`.

Use the distro Lutris package. The Flatpak build is a different sandbox, and these steps do not cover it.

## Other distros

Only Arch Linux was tested, in October 2026. The Lutris steps after the packages are installed should be the same. Those steps were not run anywhere but Arch.

| Page | Package manager | Status |
| --- | --- | --- |
| [Arch Linux](docs/arch.md) | `pacman` | Tested, October 2026 |
| [CachyOS](docs/cachyos.md) | `pacman` | Not tested. Same commands as Arch. |
| [EndeavourOS](docs/endeavouros.md) | `pacman` | Not tested. Same commands as Arch. |
| [Manjaro](docs/manjaro.md) | `pacman` | Not tested. Same commands as Arch. |
| [Debian](docs/debian.md) | `apt` | Not tested. No install command listed. |
| [Ubuntu](docs/ubuntu.md) | `apt` | Not tested. No install command listed. |
| [Linux Mint](docs/linux-mint.md) | `apt` | Not tested. No install command listed. |
| [Pop!_OS](docs/pop-os.md) | `apt` | Not tested. No install command listed. |
| [Fedora](docs/fedora.md) | `dnf` | Not tested. No install command listed. |
| [SteamOS](docs/steamos.md) | immutable | Not covered. |
| [Bazzite](docs/bazzite.md) | immutable | Not covered. |

## Install DXVK first

Lutris does not ship DXVK in the package. If you skip this, the Battle.net installer stops with:

```text
The 'DXVK' runtime component is not installed; visit the Updates tab in the Preferences dialog to install it.
```

Open Lutris, then **Preferences**, then **Updates**, and install **DXVK**. Install **VKD3D** from that same list when it is offered. VKD3D is the DirectX 12 piece. WoW's default renderer is DirectX 11, which goes through DXVK.

Let Lutris finish any "Wine runner needs to be installed" download before you start Battle.net. Current Lutris runs that Proton build through `umu-launcher`.

## Install Battle.net

```bash
lutris lutris:install/battlenet-standard
```

Choose the **Standard** row and click **Install**.

Pick a folder on the drive where you want the games. `~/Games/battlenet` is a normal choice. That folder becomes the Wine `C:` drive. Battle.net's default path, `C:\Program Files (x86)`, is inside it, so every WoW version you add later stays on that same drive.

Use a Linux filesystem (btrfs, ext4, xfs). A prefix on NTFS is a known way to break Battle.net.

On the first Battle.net window, close the login screen without signing in. Lutris is still finishing the prefix. Start Battle.net from Lutris again, and sign in on that second launch.

The Lutris log stays open the whole time Battle.net is running. It closes when you quit Battle.net. These lines are noise when the launcher is actually open:

- `Proton: Error: unable to use parent for game drive`
- `Xalia` / `TaskCanceledException`

## Install a WoW version

Battle.net shows one World of Warcraft entry. The **Game Version** menu on that page switches clients. They share one game folder, the one you picked above.

| Version menu | Folder | Product code |
| --- | --- | --- |
| Classic Era | `_classic_era_` | `wow_classic_era` |
| WoW Classic (Mists of Pandaria in 2026) | `_classic_` | `wow_classic` |
| World of Warcraft: Forever | `_forever_` once Blizzard enables the install | `WoWF` |

Forever is not its own tile in the sidebar.

## WoW Forever

Launch is Wednesday 4 November 2026 at 3:00 p.m. Pacific, which is 23:00 UTC. Access is included with a WoW subscription or Game Time.

As of 30 October 2026, Blizzard had the Forever install disabled on purpose. The Install button stays grey. That is not a Linux bug, and it is not caused by which WoW account is selected in the launcher.

When Blizzard enables it: open World of Warcraft, open **Game Version**, choose **World of Warcraft: Forever**, then **Install**.

Windows players pass this to a grey button. It asks Battle.net to start the `WoWF` product. It does not override a disablement Blizzard still has in place:

```text
"C:\Program Files (x86)\Battle.net\Battle.net.exe" --game=WoWF --install
```

On Linux, pass the same arguments to `Battle.net.exe` inside the prefix, with the same Wine runner Lutris is using.

## Wrong Python on PATH

The `lutris` command is a script with `#!/usr/bin/env python3`. If a different `python3` is earlier on `PATH`, Lutris fails in one of two ways:

- `No module named 'lutris'`
- during prefix creation, `AttributeError: module '_thread' has no attribute 'start_joinable_thread'`

The second one happens because Lutris hands its own `PYTHONPATH` to `lutris-wrapper`, and the other interpreter cannot load that standard library.

Start Lutris with the distro interpreter:

```bash
/usr/bin/python3 /usr/bin/lutris
```

The desktop entry runs the name `lutris` and inherits your session `PATH`. A wrapper earlier on `PATH` keeps the menu entry working:

```bash
#!/usr/bin/bash
export PATH="/usr/bin:${PATH}"
exec /usr/bin/python3 /usr/bin/lutris "$@"
```

Put that in `~/.local/bin/lutris` and mark it executable, if `~/.local/bin` comes before `/usr/bin`.

## Audio

The game plays through the desktop's default output device. If the sound is distorted or on the wrong device, change the default in your sound settings and start the game again.

## Contributing

Corrections and notes for other distros go through a pull request. Read [CONTRIBUTING.md](CONTRIBUTING.md) first. People who land a change are listed by GitHub handle in [CONTRIBUTORS.md](CONTRIBUTORS.md).

Issues use the templates in `.github/ISSUE_TEMPLATE`. Do not paste account names, emails, or full logs.

[CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) covers issues and pull requests. [SECURITY.md](SECURITY.md) is for a personal detail that should not be public.

## Trademarks and copyright

World of Warcraft, WoW, Warcraft, Battle.net, and Blizzard are trademarks or registered trademarks of Blizzard Entertainment, Inc. in the U.S. and/or other countries. Other names are the property of their respective owners.

This repository is original install notes. It does not include Blizzard's art, logos, screenshots, client files, or copied text from their games or website. Naming a product here is only so a reader can find that product.

## License

[Apache License 2.0](LICENSE). A pull request is a contribution under that license. The Apache license covers this guide. It does not license Blizzard's games or trademarks.
