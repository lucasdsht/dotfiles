import Quickshell
import QtQuick

import "modules/bar"
import "modules/background"
import "modules/powermenu"

ShellRoot {
  Background {
    wallpaperSource: "file:///home/lucasdcht/.wallpaper/wp3.png"
    useExternalWallpaper: false
  }
  
  Bar {}
}

