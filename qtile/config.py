# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from qtile_extras import widget as Ewidget
import subprocess 

mod = "mod4"
terminal = guess_terminal()


catppuccin = {
    "Rosewater": "#fbf1c7",
    "Flamingo": "#cc241d",
    "Pink": "#d3869b",
    "Mauve": "#b16286",
    "Red": "#fb4934",
    "Maroon": "#d65d62",
    "Peach": "#fe8019",
    "Yellow": "#fabd2f",
    "Green": "#b8bb26",
    "Teal": "#8ec07c",
    "Sky": "#83a598",
    "Sapphire": "#d3869b",
    "Blue": "#458588",
    "Lavender": "#b16286",
    "Text": "#ebdbb2",
    "Subtext1": "#d5c4a1",
    "Subtext0": "#bdae93",
    "Overlay2": "#a89984",
    "Overlay1": "#928374",
    "Overlay0": "#7c6f64",
    "Surface2": "#665c54",
    "Surface1": "#504945",
    "Surface0": "#3c3836",
    "Base": "#282828",
    "Mantle": "#1d2021",
    "Crust": "#fb4934"
}



keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawn("rofi -show drun"), desc="Spawn a rofi drun"),

    # Adjust keyboard backlight
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set 5%+")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-")),

    # Adjust audio volume
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q sset Master 5%+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q sset Master 5%-")),
    Key([], "XF86AudioMute", lazy.spawn("amixer -q sset Master toggle")),

    # toggle floating 
    Key([mod], 'f', lazy.window.toggle_floating()),
    Key([ "mod4", "mod1" ], "space", lazy.spawn("sh /home/lucasdcht/.local/bin/lock.sh")),
]


groups = [Group(f"{i+1}", label="") for i in range(8)]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Columns(margin=10),
    layout.Max(margin=10),
    layout.Floating(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="JetbrainsMonoNerdFont",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

basic_separator = widget.Sep(padding=10, foreground=catppuccin["Overlay1"])

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(length=25),
                widget.TextBox(
                    " ", 
                    name="arch", 
                    fontsize = 25, 
                    padding = 10, 
                    foreground=catppuccin["Blue"], 
                    mouse_callbacks={"Button1": lazy.spawn("rofi -show drun")}
                ),
                basic_separator,
                widget.TextBox(
                    " 󰻀", 
                    name="pingu", 
                    fontsize = 25, 
                    padding = 10, 
                    foreground=catppuccin["Text"], 
                    mouse_callbacks={"Button1": lazy.spawn("mplayer /home/lucasdcht/.config/qtile/assets/video/noot_noot.mp4 -fs")}
                ),
                widget.Spacer(length=15),
                widget.GroupBox(
                    center_aligned = True,
                    highlight_method = 'text',
                    highlight_color = catppuccin["Red"],
                    this_current_screen_border = catppuccin["Rosewater"],
                    active = catppuccin["Overlay1"],
                    inactive = catppuccin["Surface1"],
                    margin_x = 10,
                    rounded = True,
                    disable_drag=True,
                ),
                widget.Spacer(),
                widget.Clock(format="%d-%m-%Y | %a", fontsize=15, padding=15),
                widget.Spacer(),
                # Ewidget.GithubNotifications(token_file = "~/.config/qtile/conf/github.token"),
                widget.WidgetBox(
                    close_button_location = "right",
                    text_closed = "",
                    text_open = "",
                    fontsize = 20,
                    widgets=[
                        widget.Systray(),
                        widget.Sep(padding=10, foreground=catppuccin["Overlay1"],),
                        widget.CPU(
                            fontsize=15,
                            format=' {load_percent}%',
                            foreground = catppuccin["Sapphire"]
                        ),
                        widget.Sep(padding=10, foreground=catppuccin["Overlay1"],),
                        widget.Memory(
                            fontsize=15,
                            format=' {MemUsed: .0f} /{MemTotal: .0f}',
                            foreground = catppuccin["Mauve"]
                        ),
                        widget.Sep(padding=10, foreground=catppuccin["Overlay1"],),
                        widget.Net(format='󰛴 {down} ', fontsize=15, foreground = catppuccin["Mauve"]),
                        widget.Net(format=' 󰛶 {up}', fontsize=15, foreground = catppuccin["Sapphire"]),
                        widget.Spacer(length=10),

                    ]
                ),
                widget.Spacer(length=10),
                widget.Clock(
                    format=" 󰥔  %H:%M ", 
                        fontsize = 15,
                ),
                widget.Battery(
                    format = ' {char} {percent:2.0%}', 
                    charge_char = "󰂄", 
                    discharge_char = "󰁹", 
                    fontsize = 20,
                    low_foreground = catppuccin["Red"],
                    low_percentage = 0.20
                ), 
                widget.QuickExit(
                    default_text='󰐥', 
                    countdown_format='󰍃', 
                    fontsize = 23, 
                    foreground = catppuccin["Red"],
                    padding=15
                ),
            ],
            40,
            margin = 10,
            background=catppuccin["Base"],
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(length=25),
                widget.TextBox(
                    " ", 
                    name="arch", 
                    fontsize = 25, 
                    padding = 10, 
                    foreground=catppuccin["Blue"], 
                    mouse_callbacks={"Button1": lazy.spawn("rofi -show drun")}
                ),
                basic_separator,
                widget.TextBox(
                    " 󰻀", 
                    name="pingu", 
                    fontsize = 25, 
                    padding = 10, 
                    foreground=catppuccin["Text"], 
                    mouse_callbacks={"Button1": lazy.spawn("mplayer /home/lucasdcht/.config/qtile/assets/video/noot_noot.mp4 -fs")}
                ),
                widget.Spacer(length=15),
                widget.GroupBox(
                    center_aligned = True,
                    highlight_method = 'text',
                    highlight_color = catppuccin["Red"],
                    this_current_screen_border = catppuccin["Rosewater"],
                    active = catppuccin["Overlay1"],
                    inactive = catppuccin["Surface1"],
                    margin_x = 10,
                    rounded = True,
                    disable_drag=True,
                ),
                widget.Spacer(),
                widget.Clock(format="%d-%m-%Y | %a", fontsize=15, padding=15),
                widget.Spacer(),
                # Ewidget.GithubNotifications(token_file = "~/.config/qtile/conf/github.token"),
                widget.WidgetBox(
                    close_button_location = "right",
                    text_closed = "",
                    text_open = "",
                    fontsize = 20,
                    widgets=[
                        widget.Systray(),
                        widget.Sep(padding=10, foreground=catppuccin["Overlay1"],),
                        widget.CPU(
                            fontsize=15,
                            format=' {load_percent}%',
                            foreground = catppuccin["Sapphire"]
                        ),
                        widget.Sep(padding=10, foreground=catppuccin["Overlay1"],),
                        widget.Memory(
                            fontsize=15,
                            format=' {MemUsed: .0f} /{MemTotal: .0f}',
                            foreground = catppuccin["Mauve"]
                        ),
                        widget.Sep(padding=10, foreground=catppuccin["Overlay1"],),
                        widget.Net(format='󰛴 {down} ', fontsize=15, foreground = catppuccin["Mauve"]),
                        widget.Net(format=' 󰛶 {up}', fontsize=15, foreground = catppuccin["Sapphire"]),
                        widget.Spacer(length=10),

                    ]
                ),
                widget.Spacer(length=10),
                widget.Clock(
                    format=" 󰥔  %H:%M ", 
                        fontsize = 15,
                ),
                widget.Battery(
                    format = ' {char} {percent:2.0%}', 
                    charge_char = "󰂄", 
                    discharge_char = "󰁹", 
                    fontsize = 20,
                    low_foreground = catppuccin["Red"],
                    low_percentage = 0.20
                ), 
                widget.QuickExit(
                    default_text='󰐥', 
                    countdown_format='󰍃', 
                    fontsize = 23, 
                    foreground = catppuccin["Red"],
                    padding=15
                ),
            ],
            40,
            margin = 10,
            background=catppuccin["Base"],
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),

]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None


import os

from libqtile import hook

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
