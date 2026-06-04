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
  keepassxcProxyPkg = inputs.keepassxc-proxy-rust.defaultPackage.${system};
in
{
  services.flatpak = {
    overrides = {
      "app.zen_browser.zen".Context = {
        filesystems = [
          "${inputs.keepassxc-proxy-rust.defaultPackage.${system}}:ro"
          # proxy's runtime dependencies; confirmed to be required.
          # can be obtained with `nix-store --query -R <nix-store path for package>`
          # make sure to update these if updating keepassxc-proxy-rust
          "/nix/store/bf6wgamqnl3c91iamlb1branrfcwwy7x-libunistring-1.4.2:ro"
          "/nix/store/6qa00czc79b3nb6ld0mdyacfp2p1k3jx-libidn2-2.3.8:ro"
          "/nix/store/g54b6ghpnn98hfdz4yqw87w10c3hx8bv-xgcc-15.2.0-libgcc:ro"
          "/nix/store/57iz36553175g3178pvxjij8z5rcsd4n-glibc-2.42-61:ro"
          "/nix/store/xyikkpwkyxx6syba3kfrr0h67ig5hwmn-gcc-15.2.0-libgcc:ro"
          "/nix/store/chqq8mpmpyfi9kgsngya71akv5xicn03-gcc-15.2.0-lib:ro"
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
