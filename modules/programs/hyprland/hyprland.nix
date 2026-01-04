{ config, pkgs, ... }:

let
  c = config.lib.stylix.colors;

  # Stylix image path (store path). Hyprlock accepts it fine.
  wall = toString config.stylix.image;

  hex = s: s; # Stylix gives hex without '#', Hyprland/Hyprlock formats below use that style.
in
{
  # ===== Hyprland main file =====
  xdg.configFile."hypr/hyprland.conf" = {
    force = true;
    text = ''
      # ~/.config/hypr/hyprland.conf

      source = ~/.config/hypr/variables.conf

      source = ~/.config/hypr/hyprland/env.conf
      source = ~/.config/hypr/hyprland/monitors.conf
      source = ~/.config/hypr/hyprland/general.conf
      source = ~/.config/hypr/hyprland/decoration.conf
      source = ~/.config/hypr/hyprland/animation.conf
      source = ~/.config/hypr/hyprland/input.conf
      source = ~/.config/hypr/hyprland/group.conf
      source = ~/.config/hypr/hyprland/misc.conf
      source = ~/.config/hypr/hyprland/rules.conf
      source = ~/.config/hypr/hyprland/execs.conf
      source = ~/.config/hypr/hyprland/keybinds.conf
    '';
  };

  # ===== Variables (Stylix colors injected here) =====
  xdg.configFile."hypr/variables.conf" = {
    force = true;
    text = ''
      # ~/.config/hypr/variables.conf

      # Apps
      $terminal = kitty
      $browser  = firefox
      $fileManager = kitty yazi
      $menu = rofi -show drun

      # Colors / sizes (Stylix)
      $active_border   = rgb(${hex c.base05})
      $inactive_border = rgba(${hex c.base03}ee)
      $rounding = 20
      $gap_in  = 7
      $gap_out = 15, 15, 15, 15
      $border  = 2
    '';
  };

  # ===== Hyprland split files =====
  xdg.configFile."hypr/hyprland/animation.conf" = {
    force = true;
    text = ''
      animations {
        enabled = true
        bezier = myBezier, 0.05, 0.9, 0.1, 1.05
        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
      }
    '';
  };

  xdg.configFile."hypr/hyprland/general.conf" = {
    force = true;
    text = ''
      general {
        gaps_in = $gap_in
        gaps_out = $gap_out
        border_size = $border
        col.active_border = $active_border
        col.inactive_border = $inactive_border
        resize_on_border = false
        allow_tearing = false
        layout = master
      }
    '';
  };

  xdg.configFile."hypr/hyprland/rules.conf" = {
    force = true;
    text = ''
      # Window / workspace rules
      # windowrule = float, ^(kitty)$
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      windowrulev2 = suppressevent maximize, class:.*
    '';
  };

  xdg.configFile."hypr/hyprland/env.conf" = {
    force = true;
    text = ''
      # Environment
      env = XCURSOR_SIZE,24
      env = HYPRCURSOR_SIZE,24
    '';
  };

  xdg.configFile."hypr/hyprland/monitors.conf" = {
    force = true;
    text = ''
      # Monitors
      monitor=,preferred,auto,1
    '';
  };

  xdg.configFile."hypr/hyprland/decoration.conf" = {
    force = true;
    text = ''
      decoration {
        rounding = $rounding
        active_opacity = 1.0
        inactive_opacity = 0.8

        blur {
          enabled = true
          size = 15
          passes = 2
          vibrancy = 0.5
          vibrancy_darkness = 0.2
        }

        shadow {
          enabled = true
          range = 13
          render_power = 3
          color = rgba(${hex c.base00}ee)
        }
      }
    '';
  };

  xdg.configFile."hypr/hyprland/group.conf" = {
    force = true;
    text = ''
      dwindle {
        pseudotile = true
        preserve_split = true
      }
      master {
        new_status = master
      }
    '';
  };

  xdg.configFile."hypr/hyprland/misc.conf" = {
    force = true;
    text = ''
      misc {
        force_default_wallpaper = 0
        disable_hyprland_logo = false
      }
    '';
  };

  # Your original autostart (swww + waybar)
  xdg.configFile."hypr/hyprland/execs.conf" = {
    force = true;
    text = ''
      # Autostart
      exec-once = swww-daemon &
      exec-once = waybar &
    '';
  };

  xdg.configFile."hypr/hyprland/input.conf" = {
    force = true;
    text = ''
      input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options = ctrl:swapcaps
        kb_rules =
        follow_mouse = 1
        sensitivity = 0
      }

      gestures {
      #  workspace_swipe = false
      }

      # Example per-device
      # device {
      #   name = epic-mouse-v1
      #   sensitivity = -0.5
      # }
    '';
  };

  xdg.configFile."hypr/hyprland/keybinds.conf" = {
    force = true;
    text = ''
      # Mod
      $mainMod = SUPER

      # Apps
      bind = $mainMod, Return, exec, [workspace 1; tile; move 0 0] $terminal
      bind = $mainMod, B, exec, $browser
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, R, exec, $menu
      bind = $mainMod, L, exec, hyprlock
      bind = $mainMod CTRL, R, exec, waybar-launch

      # Manage
      bind = $mainMod, C, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod, F, togglefloating,
      bind = $mainMod, P, pseudo
      bind = $mainMod, J, togglesplit

      # Focus
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Workspaces
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move window to workspace
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Special workspace
      bind = $mainMod, S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspace, special:magic

      # Scroll through existing workspaces
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mouse
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Sound
      bind = ,XF86AudioRaiseVolume, exec, pamixer -i 5
      bind = ,XF86AudioLowerVolume, exec, pamixer -d 5
      bind = ,XF86AudioMute, exec, pamixer -t

      # Brightness
      bind = ,XF86MonBrightnessUp, exec, brightnessctl set +10%
      bind = ,XF86MonBrightnessDown, exec, brightnessctl set 10%-

      # Player
      bind = ,XF86AudioPlay, exec, playerctl play-pause
      bind = ,XF86AudioNext, exec, playerctl next
      bind = ,XF86AudioPrev, exec, playerctl previous

      # Theme
      bind = $mainMod, T, exec, theme-switcher

      # Dashboard
      bind = $mainMod, D, global, quickshell:dashboard_toggle
    '';
  };

  # ===== Hyprlock (Stylix wallpaper + colors) =====
  xdg.configFile."hypr/hyprlock.conf" = {
    force = true;
    text = ''
      # WALLPAPER
      $wall = ${wall}

      general {
          grace = 0
      }

      # BACKGROUND
      background {
          monitor =
          path = $wall
          blur_size = 2
          blur_passes = 3 # 0 disables blurring
          noise = 0.0117
          contrast = 1.6000 # Vibrant!!!
          brightness = 0.5000
          vibrancy = 0.2500
          vibrancy_darkness = 0.1000
      }

      # PASSWORD-BOX
      input-field {
          monitor =
          size = 250, 50
          outline_thickness = 3
          dots_size = 0.26
          dots_spacing = 0.15
          dots_center = true
          dots_rounding = -1
          outer_color = rgba(${hex c.base0B}ee)
          inner_color = rgba(${hex c.base00}29)
          font_color = rgb(${hex c.base05})
          fade_on_empty = true
          placeholder_text =
          hide_input = false
          rounding = -1
          check_color = rgb(${hex c.base0A})
          fail_color = rgb(${hex c.base08})
          fail_text =
          fail_transition = 300
          position = 0, 75
          halign = center
          valign = bottom
      }

      # NOW TIME
      label {
          monitor =
          text = cmd[update:1000] echo $(date +"%H:%M:%S")
          color = rgb(${hex c.base0B})
          font_size = 70
          font_family = CaskaydiaMono Nerd Font Bold
          position = 0, 70
          halign = center
          valign = center
      }

      # DATE
      label {
          monitor =
          text = cmd[update:1000] echo $(date +"%A, %d %B %Y")
          color = rgb(${hex c.base05})
          font_size = 24
          font_family = CaskaydiaMono Nerd Font Bold
          position = 0, 0
          halign = center
          valign = center
      }

      # LOCK LOGO
      label {
          monitor =
          text = 
          color = rgb(${hex c.base05})
          font_size = 18
          font_family = JetBrainsMono Nerd Font Propo
          position = 0, 30
          halign = center
          valign = bottom
      }

      # vim: set ft=hyprlang :
    '';
  };
}

