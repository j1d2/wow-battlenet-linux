# Troubleshooting

Fixes for problems seen on the tested Arch setup. Back to the [README](../README.md).

## Lutris log noise

The Lutris log stays open the whole time Battle.net is running. It closes when you quit Battle.net. These lines are noise when the launcher is actually open:

- `Proton: Error: unable to use parent for game drive`
- `Xalia` / `TaskCanceledException`

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
