![Main Screenshot](./docs/screenshots/rice.png)

# Polymnia's personal flake
This setup might be too simple compared to what you can get with popular repos of nix users but I guess I dont do that much with my computer... I spend most of the time inside the terminal or browsers and sometimes watch anime or read books, and it works perfectly fine for that.

I managed to write this configuration after a short tutorial on the nix language and a few documentation pages. I'm not too sure if this flake breaks conventions or does something awfully wrong but for now it just werks on my machines.

I refuse to apply abstraction layers beyond the base nix tools so this configuration will stay free of libraries and wrapped programs. I dont like home manager either.

# Some features
- Niri + Noctalia desktop.
- Some overlays for nightly builds (neovim, firefox, noctalia).
- Fish shell.
- TODO: Manage secrets.
- TODO: Upload all dotfiles and link them properly
- TODO: Migrate to Umbriel

# Resources
For  beginners I highly recommend getting the basics down before even touching your new system, specifically learning the basics of the nix language, this short tutorial makes the research so much easier.

[A tour of Nix](https://nixcloud.io/tour/?id=introduction/nix)

# Usage
Build
`$ sudo nixos-rebuild switch --flake .#[host] --accept-flake-config`

Update
`$ sudo nix flake update`

Clean (yes I dont keep backups)
`$ sudo nix-collect-garbage -d`

# Screenshots
![screenshot2](./docs/screenshots/rice1.png)

![screenshot4](./docs/screenshots/rice4.png)

![screenshot3](./docs/screenshots/rice2.png)


