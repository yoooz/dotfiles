import QtQuick
import Quickshell.Io
import qs.Ui
import qs.Commons

BarWidget {
  id: root
  moduleName: "yoooz.ime-status"
  property int imeState: 0

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  Process {
    id: query
    command: ["fcitx5-remote"]
    stdout: StdioCollector {
      onStreamFinished: {
        const state = Number(text.trim())
        root.imeState = state === 1 || state === 2 ? state : 0
      }
    }
    onExited: function(exitCode, exitStatus) {
      if (exitCode !== 0) root.imeState = 0
    }
  }

  Component.onCompleted: query.running = true
  Timer {
    interval: 500
    running: true
    repeat: true
    onTriggered: {
      if (!query.running) query.running = true
    }
  }

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.imeState === 2 ? "あ ON" : root.imeState === 1 ? "A OFF" : "IME ?"
    active: root.imeState === 2
    dimmed: root.imeState !== 2
    pressable: false
    horizontalMargin: 10
    fontSize: Style.font.body
    tooltipText: root.imeState === 2 ? "日本語入力 ON（Fcitx5）" : root.imeState === 1 ? "直接入力（英数字）" : "入力状態を取得できません"
  }
}
