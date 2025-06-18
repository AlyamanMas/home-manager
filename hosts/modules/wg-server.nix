{
  config,
  pkgs,
  lib,
  ...
}:

{
  # enable NAT
  networking.nat.enable = true;
  networking.nat.externalInterface = "enp1s0";
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };

  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "10.100.0.1/24" ];

      # The port that WireGuard listens to. Must be accessible by the client.
      listenPort = 51820;

      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o enp1s0 -j MASQUERADE
      '';

      # This undoes the above command
      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o enp1s0 -j MASQUERADE
      '';

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "/root/.wg-keys/private";

      peers = [
        # List of allowed peers.
        {
          name = "YPC2-NIXOS2";
          # Feel free to give a meaningful name
          # Public key of the peer (not a file path).
          publicKey = "fwzpIPRi/OMJaMI7JKHSnGGAozZTz72GnJbEXyA3VzY=";
          # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
          allowedIPs = [ "10.100.0.2/32" ];
        }
        {
          name = "YPh4";
          # Feel free to give a meaningful name
          # Public key of the peer (not a file path).
          publicKey = "D9j0GeZLfbb3HyO+9pbyVrMepZrOsq/sjy583vqx0A4=";
          # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
          allowedIPs = [ "10.100.0.3/32" ];
        }
        {
          name = "YPC2-WINDOWS";
          # Feel free to give a meaningful name
          # Public key of the peer (not a file path).
          publicKey = "r/NKzl+mZqsKq2iuXF2dKGspIxHZn4KlcUCUaBw8cmY=";
          # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
          allowedIPs = [ "10.100.0.4/32" ];
        }
        {
          name = "YPh4-2";
          # Feel free to give a meaningful name
          # Public key of the peer (not a file path).
          publicKey = "+aLaUVfJnOHseh/syjyhMAqZt0XNHXVawRAdcHp4kUg=";
          # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
          allowedIPs = [ "10.100.0.5/32" ];
        }
        {
          name = "YPh4-3";
          # Feel free to give a meaningful name
          # Public key of the peer (not a file path).
          publicKey = "BXNqsNUqJ4z/V2+Rk6Mc+UYDZ8ZShrC0UEkHhp+jPk8=";
          # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
          allowedIPs = [ "10.100.0.6/32" ];
        }
      ];
    };
  };
}
