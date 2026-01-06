{ config, pkgs, ... }:

{
  services.swaync = {
    enable = true;

    # ====== Config (adapté depuis ton config.json) ======
    settings = {
      # (optionnel) schema: pas nécessaire côté HM, swaync s’en fout
      # "$schema" = "$XDG_CONFIG_HOME/swaync/configSchema.json";

      "control-center-height" = 2;
      "control-center-layer" = "overlay";
      "control-center-margin-bottom" = 20;
      "control-center-margin-left" = 0;
      "control-center-margin-right" = 10;
      "control-center-margin-top" = 20;
      "control-center-width" = 500;

      "cssPriority" = "application";

      "control-center-positionX" = "right";
      "control-center-positionY" = "center";

      "fit-to-screen" = true;
      "hide-on-action" = false;
      "hide-on-clear" = false;

      "image-visibility" = "when-available";
      "keyboard-shortcuts" = true;

      # IMPORTANT: tu avais "layer": "layer" dans le JSON (valeur invalide).
      # Swaync attend "overlay" / "top" / "bottom" selon la version/config.
      # Mets "overlay" pour être cohérent.
      "layer" = "overlay";

      "notification-body-image-height" = 100;
      "notification-body-image-width" = 200;
      "notification-icon-size" = 40;
      "notification-inline-replies" = true;

      "notification-visibility" = { };
      "notification-window-width" = 400;

      "positionX" = "right";
      "positionY" = "top";

      "script-fail-notify" = true;
      "scripts" = { };

      "timeout" = 10;
      "timeout-critical" = 0;
      "timeout-low" = 5;
      "transition-time" = 100;

      "widget-config" = {
        "buttons-grid" = {
          "actions" = [
            {
              "active" = false;
              "command" = "notify-send 'hey'";
              "label" = "󰤄";
              "type" = "toggle";
              "update_command" = "notify-send 'Hi'";
            }
            {
              "active" = false;
              "command" = "swaync-client -d";
              "label" = "";
              "type" = "toggle";
            }
            {
              "active" = false;
              "command" = "obs";
              "label" = "󰄀";
              "type" = "button";
            }
            {
              "active" = false;
              "command" = "obs";
              "label" = "󰕧";
              "type" = "button";
            }
            {
              "active" = false;
              "command" = "swaync-client -t";
              "label" = "";
              "type" = "toggle";
            }
          ];
        };

        "mpris" = {
          "image-radius" = 12;
          "image-size" = 96;
        };

        "title" = {
          "text" = "Notifications";
          "button-text" = "󰎟  Clear";
          "clear-all-button" = true;
        };

        "volume" = {
          "label" = "";
          "show-per-app" = true;
          "show-per-app-icon" = true;
          "show-per-app-label" = true;
        };
      };

      "widgets" = [
        "title"
        "notifications"
        "buttons-grid"
        "mpris"
        "volume"
      ];
    };

    # ====== CSS (adapté depuis ton style.css) ======
    # - garde ton import matugen
    # - enlève -gtk-outline-radius (warnings)
    # - corrige le selector ".notification..notification-content"
    style = ''
      @import 'colors/colors.css';

      * {
        font-size: 14px;
        font-family: "Adwaita Sans", "JetBrainsMono Nerd Font Propo";
        transition: 100ms;
        box-shadow: unset;
      }

      .control-center .notification-row {
        background-color: unset;
      }

      .control-center .notification-row .notification-background .notification,
      .control-center .notification-row .notification-background .notification .notification-content,
      .floating-notifications .notification-row .notification-background .notification,
      .floating-notifications.background .notification-background .notification .notification-content {
        margin-bottom: unset;
      }

      .control-center .notification-row .notification-background .notification {
        margin-top: 0.150rem;
      }

      .control-center .notification-row .notification-background .notification box,
      .control-center .notification-row .notification-background .notification widget,
      .control-center .notification-row .notification-background .notification .notification-content,
      .floating-notifications .notification-row .notification-background .notification box,
      .floating-notifications .notification-row .notification-background .notification widget,
      .floating-notifications.background .notification-background .notification .notification-content {
        border: unset;
        border-radius: 1.159rem;
      }

      .floating-notifications.background .notification-background .notification .notification-content,
      .control-center .notification-background .notification .notification-content {
        background-color: @surface_variant;
        padding: 0.818rem;
        padding-right: unset;
        margin-right: unset;
      }

      .control-center .notification-row .notification-background .notification.low .notification-content label,
      .control-center .notification-row .notification-background .notification.normal .notification-content label,
      .floating-notifications.background .notification-background .notification.low .notification-content label,
      .floating-notifications.background .notification-background .notification.normal .notification-content label {
        color: @on_surface;
      }

      /* FIX: double-dot => ".notification .notification-content" */
      .control-center .notification-row .notification-background .notification .notification-content image,
      .floating-notifications.background .notification-background .notification .notification-content image {
        background-color: unset;
        color: #e2e0f9;
      }

      .control-center .notification-row .notification-background .notification.low .notification-content .body,
      .control-center .notification-row .notification-background .notification.normal .notification-content .body,
      .floating-notifications.background .notification-background .notification.low .notification-content .body,
      .floating-notifications.background .notification-background .notification.normal .notification-content .body {
        color: #92919a;
      }

      .control-center .notification-row .notification-background .notification.critical .notification-content,
      .floating-notifications.background .notification-background .notification.critical .notification-content {
        background-color: @error;
      }

      .control-center .notification-row .notification-background .notification.critical .notification-content image,
      .floating-notifications.background .notification-background .notification.critical .notification-content image {
        background-color: unset;
        color: @error;
      }

      .control-center .notification-row .notification-background .notification.critical .notification-content label,
      .floating-notifications.background .notification-background .notification.critical .notification-content label {
        color: @on_surface;
      }

      .control-center .notification-row .notification-background .notification .notification-content .summary,
      .floating-notifications.background .notification-background .notification .notification-content .summary {
        font-size: 0.9909rem;
        font-weight: 500;
      }

      .control-center .notification-row .notification-background .notification .notification-content .time,
      .floating-notifications.background .notification-background .notification .notification-content .time {
        font-size: 0.8291rem;
        font-weight: 500;
        margin-right: 1rem;
        padding-right: unset;
      }

      .control-center .notification-row .notification-background .notification .notification-content .body,
      .floating-notifications.background .notification-background .notification .notification-content .body {
        font-size: 0.8891rem;
        font-weight: 400;
        margin-top: 0.310rem;
        padding-right: unset;
        margin-right: unset;
      }

      .control-center .notification-row .close-button,
      .floating-notifications.background .close-button {
        background-color: unset;
        border-radius: 100%;
        border: none;
        box-shadow: none;
        margin-right: 13px;
        margin-top: 6px;
        margin-bottom: unset;
        padding-bottom: unset;
        min-height: 20px;
        min-width: 20px;
        text-shadow: none;
      }

      .control-center .notification-row .close-button:hover,
      .floating-notifications.background .close-button:hover {
        background-color: rgba(255, 255, 255, 0.15);
      }

      .control-center {
        border-radius: 1.705rem;
        border-top: 1px solid rgba(164, 162, 167, 0.19);
        border-left: 1px solid rgba(164, 162, 167, 0.19);
        border-right: 1px solid rgba(128, 127, 132, 0.145);
        border-bottom: 1px solid rgba(128, 127, 132, 0.145);
        box-shadow: 0px 2px 3px rgba(0, 0, 0, 0.45);
        margin: 7px;
        background-color: @surface;
        padding: 1.023rem;
      }

      /* Buttons widget */
      .widget-buttons-grid>flowbox>flowboxchild>button label {
        font-family: "Materials Symbol Rounded";
        font-size: 1.3027rem;
        color: @on_surface;
      }

      .widget-buttons-grid>flowbox>flowboxchild>button:checked {
        background-color: @primary;
      }

      .widget-buttons-grid>flowbox>flowboxchild>button:checked label {
        color: @surface;
      }

      /* Volume */
      .widget-volume trough slider {
        background-color: @primary;
        border-radius: 100%;
        min-height: 1.25rem;
      }
    '';
  };
}

