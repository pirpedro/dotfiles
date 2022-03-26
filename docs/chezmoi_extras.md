# Chezmoi Extras

Some useful configuration file improvements powered by [`chezmoi.io`](https://www.chezmoi.io/).

- [Chezmoi Extras](#chezmoi-extras)
  - [Custom data](#custom-data)
    - [Machine State](#machine-state)
    - [Commands](#commands)
  - [Chezmoipackages](#chezmoipackages)
  - [Chezmoigit](#chezmoigit)

## Custom data

### Machine State

- `.is.ephemeral` - a cloud or VM instance. Deetect GitHub codespaces, VSCode remote containers, Docker containers, Multipass VMs, and Vagrant boxes
- `.is.headless` - this machine does not have a screen and keyboard
- `.is.wsl` - this machine is a unix WSL instance hosted in a Windows OS.
- `.is.personal` - this machine is for personal usage.
- `.is.work` - this machine is restricted for work or is from your company.

---

### Commands

Commands that work on diferents distros. Like `OsX`, `Debian-Like` (debian, ubuntu, min, popOS...), `Fedora`, `Open Suse` and `Alpine`.

- `.cmd.sudo` - will return super user privileges if you need.
- `.cmd.update` - update command for current distro.
- `.cmd.upgrade` - upgrade command for current distro.
- `.cmd.install` - install command for current distro.
- 
<p align="right"><a href="#top" title="Back to top">🔝</a></p>


## Chezmoipackages

A `yaml` file named `.chezmoipackages.yaml` could be created at your source dir root level with this example format:

```yaml
packages:
  - curl
  - wget
  - ripgrep: {alias: rg}
  - fzf
  - github: {alias: gh, not: ephemeral:work}
  - sushi: {not: headless, de: gnome}
```
This file (treated as a chezmoi `template`) contains all packages to be installed following those rules:
- Try to find a `template` in `<source-dir>/.chezmoitemplates/packages` with the name `<package-name>.sh` to be sourced.
  - If it doesn't exist, try to install the `<package-name>` from the current distro package manager.
- Try to find in `$PATH` a command with the `<package-name>` or an `alias` if provided, so this package installation could be skipped.
- Check some desktop environment restrictions as a `de` tag has been provided, e.g, if you said that `sushi` can be installed only in `gnome`, skip installation if your system uses `kde`.
- Restrict installation to some [machine states](#machine-state) if `not` tag exists, e.g, don't install `github cli` if your system is `ephemeral` or `work` (you can pass multiple states separated by colon)

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Chezmoigit

A `yaml` file named `.chezmoigit.yaml` could be created at your source dir root level with this example format:

```yaml
workspaces:
  all:
    root: dev/ws
  personal:
    root: dev/ws/my
      repos:
        - name: pirpedro/pirpedro.github.io:blog/personal
        - name: psrandom/psrandom.github.io.git:blog/psrandom
          provider: git@companyname.com
        - name: pirpedro/dotfiles

```
Multiple workspaces can be created. All repositories in this file will be cloned in the location $HOME/`root`/`repos.name` (without the user name), e.g., the repo `pirpedro/dotfiles` will be installed with the command:

```bash
git clone git@github.com:pirpedro/dotfiles.git $HOME/dev/ws/dotfiles
```

As expected, if you gave a different `provider` and/or separated the repo name with a colon, the last part will be used as the directory name.

```bash
git clone git@companyname.com:psrandom/psrandom.github.io.git $HOME/dev/ws/blog/psrandom
```

All `workspace` names are configured in your git config file to be used with `git bulk` if this is installed.

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

---

<p align="center"><strong>Don't forget to <a href="#" title="star">⭐️</a> or <a href="#" title="fork">🔱</a> this repo! 😃<br/><sub>Assembled with <b title="love">❤️</b> in Rio de Janeiro.</sub></strong></p>