{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:

let
  system = pkgs.stdenv.system;
  flatpakPkgs = config.services.flatpak.packages;
  # if installing FF or another browser in the future, add it here as well
  needKeepassxcRustProxy =
    lib.lists.any (flatpakPackage: flatpakPackage.appId == "org.keepassxc.KeePassXC") flatpakPkgs
    && lib.lists.any (flatpakPackage: flatpakPackage.appId == "app.zen_browser.zen") flatpakPkgs;
  keepassxcProxyPkg = inputs.keepassxc-proxy-rust.packages.${system}.static;
in
{
  services.flatpak = {
    overrides = {
      "app.zen_browser.zen".Context = {
        filesystems = [
          "${keepassxcProxyPkg}:ro"
          # the keepassxc socket; new format (first), and old format (latter)
          "xdg-run/app/org.keepassxc.KeePassXC/org.keepassxc.KeePassXC.BrowserServer"
          "xdg-run/kpxc_server"

          # for some reason, even when running inside flatpak, zen still tries to access `/home/<user>/.mozilla` for native messaging
          "${config.home.homeDirectory}/.mozilla:ro"
        ];
      };
    };
  }; # end services.flatpak

  # using home.file makes the file a symlink to the nix-store, and it is not possible to determine dir of nix-store derivation at evaluation time since that would cause infinite recursion. so we use systemd-tmpfiles instead.
  systemd.user.tmpfiles.rules = [
    ''f    ${config.home.homeDirectory}/.mozilla/native-messaging-hosts/org.keepassxc.keepassxc_browser.json    0644    ${config.home.username}    -    -    {"allowed_extensions":["keepassxc-browser@keepassxc.org"],"description":"KeePassXC integration with native messaging support","name":"org.keepassxc.keepassxc_browser","path":"${keepassxcProxyPkg}/bin/keepassxc-proxy","type":"stdio"}''
  ];

  home.packages = if needKeepassxcRustProxy then [ keepassxcProxyPkg ] else [ ];
}
