import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "omarchy.workspaces"

  readonly property string screenName: QsWindow.window && QsWindow.window.screen
    ? QsWindow.window.screen.name : ""
  readonly property var workspaces: monitorWorkspaces()

  function monitorWorkspaces() {
    var workspaces = []
    var values = Hyprland.workspaces.values
    for (var i = 0; i < values.length; i++) {
      var workspace = values[i]
      if (workspace.id > 0 && workspace.monitor && workspace.monitor.name === root.screenName)
        workspaces.push(workspace)
    }
    workspaces.sort(function(left, right) { return left.id - right.id })
    return workspaces
  }

  function focusWorkspace(id) {
    if (!root.bar) return
    root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"" + id + "\" })"))
  }

  readonly property real trailingGap: root.vertical ? 0 : Style.spaceReal(1.5)

  implicitWidth: grid.implicitWidth + trailingGap
  implicitHeight: grid.implicitHeight

  GridLayout {
    id: grid
    anchors.fill: parent
    anchors.rightMargin: root.trailingGap
    columns: root.vertical ? 1 : Math.max(1, root.workspaces.length)
    columnSpacing: root.vertical ? 0 : Style.space(1)
    rowSpacing: root.vertical ? Style.space(2) : 0

    Repeater {
      model: root.workspaces

      WidgetButton {
        id: button
        required property int index
        required property var modelData

        readonly property var workspace: modelData
        readonly property bool occupied: workspace.toplevels.values.length > 0

        bar: root.bar
        text: String(index + 1)
        active: workspace.active
        opacity: occupied || active ? 1 : 0.45
        tooltipText: "ワークスペース " + text + " · " + workspace.toplevels.values.length + " ウィンドウ"
        horizontalMargin: 6
        verticalPadding: 6
        fixedWidth: root.vertical ? root.barSize : Style.space(32)
        fixedHeight: root.barSize
        onPressed: function(mouseButton) {
          if (mouseButton === Qt.LeftButton) root.focusWorkspace(workspace.id)
        }

        Rectangle {
          visible: button.active
          anchors.bottom: parent.bottom
          anchors.horizontalCenter: parent.horizontalCenter
          width: parent.width - Style.space(12)
          height: 2
          color: button.activeColor
        }
      }
    }
  }
}
