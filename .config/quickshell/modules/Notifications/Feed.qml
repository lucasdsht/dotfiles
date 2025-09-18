import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.services

Rectangle {
  id: feed
  color: Theme.surface0
  radius: Theme.roundedMd
  border.color: Theme.border
  border.width: Theme.borderSm

  ListModel { id: notifications }

  Daemon {
    onNewNotification: (summary, body) => {
      notifications.insert(0, { summary: summary, body: body })
      if (notifications.count > 100) notifications.remove(notifications.count - 1)
    }
  }

  ListView {
    anchors.fill: parent
    model: notifications
    spacing: 6
    clip: true

    delegate: Rectangle {
      width: parent.width
      height: implicitHeight
      radius: Theme.roundedSm
      color: Theme.surface1
      border.color: Theme.border
      anchors.margins: 4

      Column {
        anchors.fill: parent
        anchors.margins: 8
        Label { text: summary; font.bold: true; color: Theme.text }
        Label { text: body; wrapMode: Text.Wrap; color: Theme.subtext0 }
      }
    }
  }
}

