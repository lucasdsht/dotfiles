pragma Singleton
import QtQuick

QtObject {
    id: root

    // Toggle here (or bind from outside)
    property bool isDarkTheme: true

    function toggleTheme() {
        root.isDarkTheme = !root.isDarkTheme
    }

    // ── Catppuccin Mocha (Dark)
    readonly property var mocha: ({
        rosewater: "#f5e0dc",
        flamingo:  "#f2cdcd",
        pink:      "#f5c2e7",
        mauve:     "#cba6f7",
        red:       "#f38ba8",
        maroon:    "#eba0ac",
        peach:     "#fab387",
        yellow:    "#f9e2af",
        green:     "#a6e3a1",
        teal:      "#94e2d5",
        sky:       "#89dceb",
        sapphire:  "#74c7ec",
        blue:      "#89b4fa",
        lavender:  "#b4befe",

        text:      "#cdd6f4",
        subtext1:  "#bac2de",
        subtext0:  "#a6adc8",

        overlay2:  "#9399b2",
        overlay1:  "#7f849c",
        overlay0:  "#6c7086",
        surface2:  "#585b70",
        surface1:  "#45475a",
        surface0:  "#313244",

        base:      "#1e1e2e",
        mantle:    "#181825",
        crust:     "#11111b"
    })

    // ── Catppuccin Latte (Light)
    readonly property var latte: ({
        rosewater: "#dc8a78",
        flamingo:  "#dd7878",
        pink:      "#ea76cb",
        mauve:     "#8839ef",
        red:       "#d20f39",
        maroon:    "#e64553",
        peach:     "#fe640b",
        yellow:    "#df8e1d",
        green:     "#40a02b",
        teal:      "#179299",
        sky:       "#04a5e5",
        sapphire:  "#209fb5",
        blue:      "#1e66f5",
        lavender:  "#7287fd",

        text:      "#4c4f69",
        subtext1:  "#5c5f77",
        subtext0:  "#6c6f85",

        overlay2:  "#7c7f93",
        overlay1:  "#8c8fa1",
        overlay0:  "#9ca0b0",
        surface2:  "#acb0be",
        surface1:  "#bcc0cc",
        surface0:  "#ccd0da",

        base:      "#eff1f5",
        mantle:    "#e6e9ef",
        crust:     "#dce0e8"
    })

    // ── Active palette (switches with isDarkTheme)
    readonly property var palette: isDarkTheme ? mocha : latte

    // ── Exposed properties
    readonly property color rosewater: palette.rosewater
    readonly property color flamingo:  palette.flamingo
    readonly property color pink:      palette.pink
    readonly property color mauve:     palette.mauve
    readonly property color red:       palette.red
    readonly property color maroon:    palette.maroon
    readonly property color peach:     palette.peach
    readonly property color yellow:    palette.yellow
    readonly property color green:     palette.green
    readonly property color teal:      palette.teal
    readonly property color sky:       palette.sky
    readonly property color sapphire:  palette.sapphire
    readonly property color blue:      palette.blue
    readonly property color lavender:  palette.lavender

    readonly property color text:      palette.text
    readonly property color subtext1:  palette.subtext1
    readonly property color subtext0:  palette.subtext0

    readonly property color overlay2:  palette.overlay2
    readonly property color overlay1:  palette.overlay1
    readonly property color overlay0:  palette.overlay0
    readonly property color surface2:  palette.surface2
    readonly property color surface1:  palette.surface1
    readonly property color surface0:  palette.surface0

    readonly property color base:      palette.base
    readonly property color mantle:    palette.mantle
    readonly property color crust:     palette.crust

    // Common aliases
    readonly property color background: base
    readonly property color panel:      mantle
    readonly property color border:     surface2
    readonly property color accent:     lavender

    // Wallpaper
    readonly property string wallpaper: isDarkTheme
        ? "file:///home/lucasdcht/.wallpaper/wp4.png"
        : "file:///home/lucasdcht/.wallpaper/wp5.png"

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

