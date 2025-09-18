import QtQuick
import QtQuick.Controls
import Quickshell
import qs.utils
import qs.services.Notifications

Item {
  id: manager
  anchors.top: parent.top
  anchors.right: parent.right
  anchors.margins: 12
  width: 360
  height: parent.height

  property int popupTimeout: 5000 // 5s

  Column {
    id: popupColumn
    anchors.top: parent.top
    anchors.right: parent.right
    spacing: 8
  }

  NotificationDaemon {
    onNewNotification: (summary, body) => {
      const comp = popupDelegate.createObject(popupColumn, {
        summary: summary,
        body: body
      })
      // Auto-destroy after timeout
      Qt.createQmlObject(`
        import QtQuick
        Timer {
          interval: ${manager.popupTimeout}
          running: true; repeat: false
          onTriggered: comp.destroy()
        }
      `, comp)
    }
  }

  Component {
    id: popupDelegate
    Rectangle {
      width: manager.width
      height: implicitHeight
      radius: Theme.roundedMd
      color: Theme.surface0
      border.color: Theme.border
      border.width: Theme.borderSm
      opacity: 0.95

      Column {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 4
        Label { text: summary; font.bold: true; color: Theme.text }
        Label { text: body; wrapMode: Text.Wrap; color: Theme.subtext0 }
      }
    }
  }
}

