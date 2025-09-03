pragma Singleton
import Quickshell
import QtQuick

pragma Singleton
import QtQuick 2.15

Singleton {
    id: root


    // Core
    readonly property color rosewater: "#f5e0dc"
    readonly property color flamingo:  "#f2cdcd"
    readonly property color pink:      "#f5c2e7"
    readonly property color mauve:     "#cba6f7"
    readonly property color red:       "#f38ba8"
    readonly property color maroon:    "#eba0ac"
    readonly property color peach:     "#fab387"
    readonly property color yellow:    "#f9e2af"
    readonly property color green:     "#a6e3a1"
    readonly property color teal:      "#94e2d5"
    readonly property color sky:       "#89dceb"
    readonly property color sapphire:  "#74c7ec"
    readonly property color blue:      "#89b4fa"
    readonly property color lavender:  "#b4befe"

    // Text
    readonly property color text:      "#cdd6f4"
    readonly property color subtext1:  "#bac2de"
    readonly property color subtext0:  "#a6adc8"

    // Surface
    readonly property color overlay2:  "#9399b2"
    readonly property color overlay1:  "#7f849c"
    readonly property color overlay0:  "#6c7086"
    readonly property color surface2:  "#585b70"
    readonly property color surface1:  "#45475a"
    readonly property color surface0:  "#313244"

    // Base layers
    readonly property color base:      "#1e1e2e"
    readonly property color mantle:    "#181825"
    readonly property color crust:     "#11111b"

    // Common aliases
    readonly property color background: base
    readonly property color panel:      mantle
    readonly property color border:     surface2
    readonly property color accent:     lavender


    // wallpaper
    readonly property string wallpaper: "file:///home/lucasdcht/.wallpaper/wp4.png"


    // Radius sizes
    readonly property int roundedSm: 6
    readonly property int roundedMd: 12
    readonly property int roundedLg: 20

    // Border sizes
    readonly property int borderSm: 1
    readonly property int borderMd: 2
    readonly property int borderLg: 3
    readonly property int borderXxl: 10

}

