# Agent notes

This repository is a public install guide. It is not a dump of one person's machine.

## Do

- Edit [README.md](README.md) for install steps. Keep it short: each distro's details go on its page in `docs/`, and fixes go in [docs/troubleshooting.md](docs/troubleshooting.md). Put contribution policy in [CONTRIBUTING.md](CONTRIBUTING.md), not in the guide.
- Date any claim about Blizzard's launcher. WoW Forever installs from the Game Version menu; that was checked on the tested Arch setup in November 2026.
- Say which distro a package command is for. Arch commands use `pacman`. Do not present them as universal. Per-distro pages live in `docs/`. Arch-based pages may repeat the tested `pacman` lines and must say they were not tested. `apt` and `dnf` pages may include commands looked up in that distro's package index. Those commands must say they were looked up and not run. Leave out a package the index does not list (`umu-launcher` is not in the Debian, Ubuntu, or Fedora indexes). Do not fill in an NVIDIA driver branch that was not looked up for one GPU.
- Keep the WoW version table accurate: Classic Era is `_classic_era_`, the 2026 WoW Classic (Mists of Pandaria) client is `_classic_`, Forever's product code is `WoWF`.
- Use conventional commits (`docs:`, `fix:`, `chore:`).
- Run `scripts/check.sh` before every commit, and install the hooks once per clone with `scripts/install_hooks.sh`. Never skip a hook (`--no-verify`).

## Do not

- Add emails, account names, character names, IP addresses, hostnames, serial numbers, or a home path that identifies someone. `~/Games/battlenet` is fine.
- Invent a fix for game audio. The troubleshooting page only says the game uses the desktop default output.
- Force-push or commit straight to `main`. Protection rejects direct pushes. Open a pull request.
- Add a second license. This repo is Apache License 2.0.
- Add Blizzard art, logos, screenshots, client files, or text copied from their site or games. Product names stay in the guide so people can find the installer. The trademark notice in README and NOTICE stays.
