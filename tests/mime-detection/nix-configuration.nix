/**
  * General/main configuration
*/

{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Boot and hardware
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    initrd.luks.devices."luks-4528c4e5-31eb-48d7-9eff-e4cb56c31799".device =
      "/dev/disk/by-uuid/4528c4e5-31eb-48d7-9eff-e4cb56c31799";
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    keyboard.zsa.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  # General configuration
  console.keyMap = "be-latin1";

  i18n.defaultLocale = "nl_BE.UTF-8";

  networking.hostName = "pie";

  security.rtkit.enable = true;

  time.timeZone = "Europe/Brussels";

  programs.nix-ld.enable = true;

  # User configuration
  users.users.pi = {
    isNormalUser = true;
    description = "pi";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    initialPassword = "pi";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
