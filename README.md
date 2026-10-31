# Battle.net and World of Warcraft on Linux

Install the Battle.net launcher with [Lutris](https://lutris.net), then install a World of Warcraft version from inside it.

Tested in October 2026 on Arch Linux, a Wayland session, and an NVIDIA GPU, with Lutris 0.5.22 and a Proton runner Lutris downloaded. The installer below is the same one other distros use. The package commands are Arch.

Blizzard does not support Linux for these games. This is a player guide.

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

## License

[Apache License 2.0](LICENSE). A pull request is a contribution under that license.
