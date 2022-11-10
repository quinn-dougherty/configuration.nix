{ config, lib, pkgs, machine, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [ 17500 ];
    allowedUDPPorts = [ 17500 ];
  };
  systemd.user.services = {
    dropbox = {
      description = "Dropbox <cloud backup>";
      after = [ "xembedsniproxy.service" ];
      wants = [ "xembedsniproxy.service" ];
      wantedBy = [ "graphical-session.target" ];
      environment = {
        QT_PLUGIN_PATH = "/run/current-system/sw/"
          + pkgs.qt5.qtbase.qtPluginPrefix;
        QML2_IMPORT_PATH = "/run/current-system/sw/"
          + pkgs.qt5.qtbase.qtQmlPrefix;
      };
      serviceConfig = {
        ExecStart = "${machine.pkgs.dropbox.out}/bin/dropbox";
        ExecReload = "${machine.pkgs.coreutils.out}/bin/kill -HUP $MAINPID";
        KillMode = "control-group";
        Restart = "on-failure";
        PrivateTmp = true;
        ProtectSystem = "full";
        Nice = 10;
      };
    };
  };
}
