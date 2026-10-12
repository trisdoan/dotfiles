# omarchy-apple-dev: security for users

Applies to the project installed by `run_onchange_after_23-omarchy-apple-dev.sh.tmpl`.
It installs toolchains, runs parts of itself as root, and handles Apple signing
keys, so treat it like a privileged tool. Scan date: 2026-10-12, upstream commit
`1d42ec4`. The scan found no committed secrets and no exploitable vulnerabilities.

## Before the first `chezmoi apply`

- Read `install-toolchain.sh` upstream at the pinned commit. It runs `sudo pacman`
  and `yay -S --noconfirm swift-bin`, which builds an AUR package without showing
  the PKGBUILD. Run `yay -G swift-bin` first and read the PKGBUILD.
- The pin lives in `.chezmoidata/omarchy-apple-dev.yaml`. Move `rev` only after
  reviewing `git log` and the diff upstream, because the scripts run with your
  privileges.
- The installer needs a terminal (it asks for a mode and for sudo). Run the first
  apply from a real shell, not from a script or CI.

## Protect the App Store Connect key

The `.p8` file (`ASC_KEY_PATH`) can create certificates and upload builds.

```bash
mkdir -p ~/.appstoreconnect && chmod 700 ~/.appstoreconnect
chmod 600 ~/.appstoreconnect/AuthKey_*.p8
```

- Create the key with the App Manager role, never Admin.
- Never put it in this dotfiles repo. `.chezmoiignore` already blocks `*.pem`
  and `*.key`; also keep `*.p8`, `*.p12` and `*.mobileprovision` out.
- Set `ASC_KEY_ID`, `ASC_ISSUER_ID` and `ASC_KEY_PATH` for a single command only.
  Do not export them in `~/.bashrc`.
- If it may have leaked, revoke it in App Store Connect (Users and Access,
  Integrations). Deleting the file does not invalidate a copy.
- Keys that `tools/asc.py` and `tools/provision-dev.py` generate (`key.pem`) are
  stored unencrypted. Use full-disk encryption.

## Avoid root when you can

- `device-run.sh` works without `--sudo` through a userspace tunnel. Use `--sudo`
  and `--over-tailnet` only when needed. They run Python from your user-owned
  venv as root, so malware already running as you could swap it.
- `pymobiledevice3` is installed unpinned from PyPI. Pin the version you tested:
  `~/pmd3/bin/pip install "pymobiledevice3==<version>"`.

## Phone pairing

- `tools/tailnet-tunnel.py pair` writes `~/.local/share/pymobiledevice3/remote_*.plist`.
  Whoever holds that file can control your phone. Treat it like an SSH key and
  copy it only to hosts you own.
- Use Tailscale ACLs so only your devices reach the phone's `100.x` address.
- Turn on Developer Mode only while developing. Tap Trust only on your own machine.
- Prefer a separate Apple ID for free-account signing (`xtool install`).

## Third-party code

- `compat/*/setup.sh` clone and build NetNewsWire, IceCubes and Mastodon. They
  are pinned to a commit, but you still run code you did not write. Use a
  throwaway user or container.
- `flutter/setup.sh` clones `depot_tools` from HEAD and runs download hooks.
  This is the least pinned part of the project.
- `tools/simctl-remote.sh` uses predictable `/tmp` paths. Do not run it on a
  shared machine.

## Quick checklist

1. Read the PKGBUILD and the pinned installer.
2. `chmod 600` the `.p8` key; role App Manager only.
3. Pin `pymobiledevice3`.
4. Prefer the no-root modes.
5. Guard the pairing record and restrict it with Tailscale ACLs.
6. Build third-party apps in an isolated user or container.
