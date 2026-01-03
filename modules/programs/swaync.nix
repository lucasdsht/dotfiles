{ ... }:
{
  services.swaync = {
    enable = true;

    # Optional: config.json (swaync format)
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-width = 420;
      notification-icon-size = 48;
      timeout = 6;
    };

    # Optional: CSS (style.css)
    style = ''
      /* your swaync css here */
    '';
  };
}

