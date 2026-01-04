{ config, pkgs, lib, ... }:

let
  # Use Nixpkgs fonts directly (no Stylix)
  sans = "DejaVu Sans";

  # Base16 Catppuccin Mocha palette (RRGGBB)
  # Source: catppuccin-mocha base16 scheme
  c = {
    base00 = "1e1e2e"; # crust-ish
    base01 = "181825";
    base02 = "313244";
    base03 = "45475a";
    base04 = "585b70";
    base05 = "cdd6f4";
    base06 = "f5e0dc";
    base07 = "b4befe";
    base08 = "f38ba8";
    base09 = "fab387";
    base0A = "f9e2af";
    base0B = "a6e3a1";
    base0C = "94e2d5";
    base0D = "89b4fa";
    base0E = "cba6f7";
    base0F = "f2cdcd";
  };

  hex = v: "#${v}";
in
{
  programs.waybar = {
    enable = true;

    settings = [
      {
        layer = "top";
        margin-top = 13;

        modules-left = [ "custom/launcher" "clock" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "custom/notification" "pulseaudio" "battery" "network" "power-profiles-daemon" ];

        "custom/launcher" = {
          format = "󱄅";
          on-click = "${pkgs.rofi}/bin/rofi --show drun";
        };

        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%a, %d, %b}";
        };

        "hyprland/workspaces" = {
          format = "{name}";
          persistent-workspaces = { "*" = 5; };
        };

        "custom/notification" = {
          tooltip = true;
          format = "<span size='16pt'>{icon}</span>";
          format-icons = {
            notification = "󱅫";
            none = "󰂜";
            dnd-notification = "󰂠";
            dnd-none = "󰪓";
            inhibited-notification = "󰂛";
            inhibited-none = "󰪑";
            dnd-inhibited-notification = "󰂛";
            dnd-inhibited-none = "󰪑";
          };
          return-type = "json";
          exec-if = "command -v swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            phone-muted = "";
            portable = "";
            car = "";
            default = [ "" "" ];
          };
          scroll-step = 1;
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          ignored-sinks = [ "Easy Effects Sink" ];
        };

        battery = {
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
        };

        network = {
          interface = "wlo1";
          format = "{ifname}";
          format-wifi = "{essid} ";
          format-ethernet = "{ipaddr}/{cidr} 󰊗";
          format-disconnected = "";
          tooltip-format = "{ifname} via {gwaddr} 󰊗";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
        };

        "power-profiles-daemon" = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };
      }
    ];

    # CSS (fonts from Nixpkgs/Stylix, colors from Stylix)
    style = ''
      * {
        border: none;
        border-radius: 50px;
        font-family: "${sans}", "JetBrainsMono Nerd Font Propo", Roboto, Helvetica, Arial, sans-serif;
        font-weight: 600;
        font-size: 1rem;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
      }

      tooltip {
        background: rgba(43, 48, 59, 0.5);
        border: 1px solid rgba(100, 114, 125, 0.5);
      }

      tooltip label {
        color: white;
      }

      .modules-left {
        margin-left: 15px;
      }

      .modules-right {
        margin-right: 15px;
      }

      #custom-launcher,
      #clock,
      #workspaces,
      #custom-notification,
      #pulseaudio,
      #battery,
      #network,
      #power-profiles-daemon {
        background-color: ${hex c.base00};
        margin-right: 10px;
        padding: 0 15px;
      }

      #power-profiles-daemon {
        margin: 0;
      }

      #workspaces {
        padding: 8px 5px;
        border-radius: 16px;
      }

      #workspaces button {
        background: ${hex c.base02};
        padding: 0px 6px;
        margin: 0px 3px;
        border-radius: 50px;
        color: transparent;
        transition: all 0.3s ease-in-out;
      }

      #workspaces button.active {
        background-color: ${hex c.base05};
        color: ${hex c.base02};
        min-width: 50px;
        transition: all 0.3s ease-in-out;
        font-size: 13px;
        border-radius: 5px;
      }

      #workspaces button:hover {
        background-color: ${hex c.base0B};
        color: ${hex c.base00};
        min-width: 50px;
        border-radius: 16px;
        background-size: 400% 400%;
      }

      #workspaces button.urgent {
        background-color: ${hex c.base08};
        color: ${hex c.base05};
        min-width: 50px;
        border-radius: 16px;
        background-size: 400% 400%;
        transition: all 0.3s ease-in-out;
      }
    '';
  };
}

