{ ... }:
{
  # Modern audio stack
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;        # provides PulseAudio server (so apps + waybar "pulseaudio" work)
    jack.enable = false;        # enable only if you need JACK
    wireplumber.enable = true;
  };

  services.playerctld = {
    enable = true;
  };
}
