import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.utils

Rectangle {
  id: profile
  width: parent.implicitWidth
  height: 120
  radius: Theme.roundedMd
  color: Theme.surface0
  border.color: Theme.accent
  border.width: Theme.borderSm

  RowLayout {
    anchors.fill: parent
    anchors.margins: 12
    spacing: 12

    Image {
      id: avatar
      source: "https://github.com/lucasdsht.png"
      width: 24; height: 24
      fillMode: Image.PreserveAspectFit
      smooth: true
      clip: true
    }

    ColumnLayout {
      spacing: 6

      // Username
      Label {
        id: userLabel
        text: profile.username
        color: Theme.text
        font.pixelSize: 16
        font.bold: true
      }

      // Uptime
      Label {
        id: uptimeLabel
        text: qsTr("Uptime: ") + profile.uptime
        color: Theme.subtext0
        font.pixelSize: 14
      }
    }
  }

  property string username: ""
  property string uptime: ""

  Process {
    id: getUser
    command: ["bash", "-lc", "whoami"]
    stdout: StdioCollector {
      onStreamFinished: profile.username = this.text.trim()
    }
  }

  Process {
    id: getUptime
    command: ["bash", "-lc", "uptime -p"]
    stdout: StdioCollector {
      onStreamFinished: profile.uptime = this.text.trim()
    }
  }

  Timer {
    interval: 60000; running: true; repeat: true
    onTriggered: getUptime.running = true
  }

  Component.onCompleted: {
    getUser.running = true
    getUptime.running = true
  }
}

