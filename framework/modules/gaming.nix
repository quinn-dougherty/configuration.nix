{ config, lib, pkgs, machine, ... }:
let
  factorio-token = config.age.secrets.factorio.file;
  pkgs-gaming = machine.pkgs-gaming factorio-token;
in {
  age.secrets.factorio.file = ./../../common/secrets/factorio.age;
  environment.systemPackages = with pkgs-gaming; [
    factorio
    lutris
    vulkan-tools
    vulkan-loader
    vulkan-extension-layer
    vulkan-headers
    # vulkan-tools-lunarg
    mesa
    vkBasalt
  ];
}
