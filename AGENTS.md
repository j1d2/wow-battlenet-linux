# Agent notes

This repository is a public install guide. It is not a dump of one person's machine.

## Do

- Edit [README.md](README.md) for install steps. Put contribution policy in [CONTRIBUTING.md](CONTRIBUTING.md), not in the guide.
- Date any claim about Blizzard's launcher, especially whether WoW Forever can be installed. The 30 October 2026 note says Blizzard had that install disabled on purpose.
- Say which distro a package command is for. Arch commands use `pacman`. Do not present them as universal. Per-distro pages live in `docs/`. Arch-based pages may repeat the tested `pacman` lines and must say they were not tested. Do not add `apt` or `dnf` install commands until someone has run them.
- Keep the WoW version table accurate: Classic Era is `_classic_era_`, the 2026 WoW Classic (Mists of Pandaria) client is `_classic_`, Forever's product code is `WoWF`.
- Use conventional commits (`docs:`, `fix:`, `chore:`).

## Do not

- Add emails, account names, character names, IP addresses, hostnames, serial numbers, or a home path that identifies someone. `~/Games/battlenet` is fine.
- Treat a grey Forever Install button as a Linux bug or as the wrong WoW account. Say when the note was last checked.
- Recommend the `--game=WoWF --install` flag as a way around a disablement Blizzard still has in place. The README already says the flag does not override that.
- Invent a fix for game audio. The README only says the game uses the desktop default output.
- Force-push or commit straight to `main`. Protection rejects direct pushes. Open a pull request.
- Add a second license. This repo is Apache License 2.0.
- Add Blizzard art, logos, screenshots, client files, or text copied from their site or games. Product names stay in the guide so people can find the installer. The trademark notice in README and NOTICE stays.
