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

Tested in October 2026 on Arch Linux, a Wayland session, and an NVIDIA GPU, with Lutris 0.5.22 and a Proton runner Lutris downloaded. WoW Forever was installed and played on the same setup in November 2026. The copy-paste block below is that test. Every other distro page is marked not tested.

Blizzard does not support Linux for these games. This is an unofficial player guide. It is not affiliated with, endorsed by, or sponsored by Blizzard Entertainment or Microsoft.

## TL;DR

Arch Linux. Proprietary NVIDIA driver. Tested October 2026. Enable the **multilib** repository first: `umu-launcher` and the 32-bit packages are there.

```bash
sudo pacman -S lutris wine umu-launcher python-protobuf
sudo pacman -S nvidia-utils lib32-nvidia-utils vulkan-icd-loader lib32-vulkan-icd-loader
lutris lutris:install/battlenet-standard
```

Then in Lutris: **Preferences**, **Updates**, install **DXVK**. Close the first Battle.net login window without signing in, start Battle.net from Lutris again, and sign in on that second launch.

The same `pacman` lines are on the [Arch](docs/arch.md), [CachyOS](docs/cachyos.md), [EndeavourOS](docs/endeavouros.md), and [Manjaro](docs/manjaro.md) pages. Only this block was run. Looked-up `apt` and `dnf` commands are on the pages listed in [Distros](#distros).

## Distros

Only Arch Linux was tested, in October 2026. The `apt` and `dnf` commands on those pages were looked up in each distro's package index on 31 October 2026. They were not run.

| Page | Package manager | Status |
| --- | --- | --- |
| [Arch Linux](docs/arch.md) | `pacman` | Tested, October 2026 |
| [CachyOS](docs/cachyos.md) | `pacman` | Not tested. Same commands as Arch. |
| [EndeavourOS](docs/endeavouros.md) | `pacman` | Not tested. Same commands as Arch. |
| [Manjaro](docs/manjaro.md) | `pacman` | Not tested. Same commands as Arch. |
| [Debian](docs/debian.md) | `apt` | Not tested. Commands looked up, not run. |
| [Ubuntu](docs/ubuntu.md) | `apt` | Not tested. Commands looked up, not run. |
| [Linux Mint](docs/linux-mint.md) | `apt` | Not tested. Commands looked up, not run. |
| [Pop!_OS](docs/pop-os.md) | `apt` | Not tested. Commands looked up, not run. |
| [Fedora](docs/fedora.md) | `dnf` | Not tested. Commands looked up, not run. |
| [SteamOS](docs/steamos.md) | immutable | Not covered. |
| [Bazzite](docs/bazzite.md) | immutable | Not covered. |

Each page has that distro's install command and its NVIDIA notes. The `apt` and `dnf` pages say which packages their index does not have (`umu-launcher` is not in the Debian, Ubuntu, or Fedora indexes). SteamOS and Bazzite are immutable images, so no install command is listed.

## What you need

Install these from the official Arch repositories. `umu-launcher` is in **multilib**, so enable that repository first:

```bash
sudo pacman -S lutris wine umu-launcher python-protobuf
```

`python-protobuf` is what current Lutris uses for Battle.net. Without it, Lutris logs:

```text
The Battle.net source is unavailable because Google protobuf could not be loaded.
```

On NVIDIA, the 32-bit driver userspace has to match the 64-bit driver (`lib32-nvidia-utils` with `nvidia-utils` on Arch). Also install `vulkan-icd-loader` and `lib32-vulkan-icd-loader`.

Use the distro Lutris package. The Flatpak build is a different sandbox, and these steps do not cover it.

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

The Lutris log stays open while Battle.net runs. Some errors in it are harmless: see [Troubleshooting](docs/troubleshooting.md#lutris-log-noise).

## Install a WoW version

Battle.net shows one World of Warcraft entry. The **Game Version** menu on that page switches clients. They share one game folder, the one you picked above.

| Version menu | Folder | Product code |
| --- | --- | --- |
| Classic Era | `_classic_era_` | `wow_classic_era` |
| WoW Classic (Mists of Pandaria in 2026) | `_classic_` | `wow_classic` |
| World of Warcraft: Forever | `_forever_` | `WoWF` |

Forever is not its own tile in the sidebar.

## WoW Forever

WoW Forever is live. Open World of Warcraft in Battle.net, open **Game Version**, choose **World of Warcraft: Forever**, then **Install**. It goes in `_forever_`, next to the other versions. Installed and played this way on the tested Arch setup in November 2026.

Access is included with a WoW subscription or Game Time.

## Addons

Addons go in the game's `Interface/AddOns` folder. Inside the folder you picked for Battle.net (for example `~/Games/battlenet`), that is under the Wine `C:` drive:

```text
Program Files (x86)/World of Warcraft/_forever_/Interface/AddOns
```

Create `Interface` and `AddOns` if they are not there yet. Classic Era and WoW Classic use their own folders (`_classic_era_`, `_classic_`) in the same place.

For free Forever addons that follow Blizzard's addon policy, see [wow-addons](https://github.com/j1d2/wow-addons), for example HouseLedger, an auction house price history.

## Troubleshooting

[docs/troubleshooting.md](docs/troubleshooting.md) covers harmless lines in the Lutris log, Lutris failing because of a different `python3` on `PATH`, and game audio on the wrong device.

## Contributing

Corrections and notes for other distros go through a pull request. Read [CONTRIBUTING.md](CONTRIBUTING.md) first. People who land a change are listed by GitHub handle in [CONTRIBUTORS.md](CONTRIBUTORS.md).

Issues use the templates in `.github/ISSUE_TEMPLATE`. Do not paste account names, emails, or full logs.

[CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) covers issues and pull requests. [SECURITY.md](SECURITY.md) is for a personal detail that should not be public.

## Trademarks and copyright

World of Warcraft, WoW, Warcraft, Battle.net, and Blizzard are trademarks or registered trademarks of Blizzard Entertainment, Inc. in the U.S. and/or other countries. Other names are the property of their respective owners.

This repository is original install notes. It does not include Blizzard's art, logos, screenshots, client files, or copied text from their games or website. Naming a product here is only so a reader can find that product.

## License

[Apache License 2.0](LICENSE). A pull request is a contribution under that license. The Apache license covers this guide. It does not license Blizzard's games or trademarks.
