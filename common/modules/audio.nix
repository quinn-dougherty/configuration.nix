{ ... }:

{
  sound.enable = false;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    # alsa = {
    #   enable = true;
    #   support32Bit = true;
    # };
    pulse.enable = true;
  };
}
