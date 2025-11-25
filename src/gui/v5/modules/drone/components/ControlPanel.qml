/*
    Drone Control Panel Module
    Contains all directional control buttons for the drone in a centered grid layout
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: controlPanel
    color: "#2a3f5f"
    
    property bool isConnected: false
    
    // Signals for drone actions
    signal droneAction(string action)
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 10
        
        // Title
        Text {
            text: "Manual Drone Control"
            color: "#c0c0c0"
            font.bold: true
            font.pixelSize: 18
            Layout.alignment: Qt.AlignHCenter
        }
        
        // Control buttons container
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            Column {
                anchors.centerIn: parent
                width: Math.min(parent.width * 0.9, 500)
                spacing: 8
        
                // Row 1: Connect and Home
                Row {
                    width: parent.width
                    height: 75
                    spacing: 10
                    
                    DroneButton {
                        width: (parent.width - parent.spacing) / 2
                        height: parent.height
                        label: "Connect"
                        iconSource: Qt.resolvedUrl("../../../../../gui/assets/images/connect.png")
                        enabled: true
                        onClicked: controlPanel.droneAction("connect")
                    }
                    
                    DroneButton {
                        width: (parent.width - parent.spacing) / 2
                        height: parent.height
                        label: "Home"
                        iconSource: Qt.resolvedUrl("../../../../../gui/assets/images/home.png")
                        enabled: true
                        onClicked: controlPanel.droneAction("home")
                    }
                }
                
                // Row 2: Up button (centered)
                Row {
                    width: parent.width
                    height: 75
                    
                    Item {
                        width: (parent.width - upButton.width) / 2
                        height: parent.height
                    }
                    
                    DroneButton {
                        id: upButton
                        width: (parent.parent.width - parent.parent.spacing * 2) / 3
                        height: parent.height
                        label: "Up"
                        iconSource: Qt.resolvedUrl("../../../../../gui/assets/images/up.png")
                        enabled: true
                        onClicked: controlPanel.droneAction("up")
                    }
                    
                    Item {
                        width: (parent.width - upButton.width) / 2
                        height: parent.height
                    }
                }
        
                // Row 3: Forward button
                DroneButton {
                    width: parent.width
                    height: 90
                    label: "Forward"
                    iconSource: Qt.resolvedUrl("../../../../../gui/assets/images/Forward.png")
                    enabled: true
                    onClicked: controlPanel.droneAction("forward")
                }
                
                // Row 4: Directional controls
                Row {
                    width: parent.width
                    height: 75
                    spacing: 8
            
                    DroneButton {
                        width: (parent.width - parent.spacing * 4) / 5
                        height: parent.height
                        label: "Turn Left"
                        iconSource: Qt.resolvedUrl("../../../../../gui/assets/images/turnLeft.png")
                        enabled: true
                        onClicked: controlPanel.droneAction("turn_left")
                    }
                    
                    DroneButton {
                        width: (parent.width - parent.spacing * 4) / 5
                        height: parent.height
                        label: "Left"
                        iconSource: Qt.resolvedUrl("../../../../../gui/assets/images/left.png")
                        enabled: true
                        onClicked: controlPanel.droneAction("left")
                    }
                    
                    DroneButton {
                        width: (parent.width - parent.spacing * 4) / 5
                        height: parent.height
                        label: "Stream"
                        iconSource: Qt.resolvedUrl("../../../../../gui/assets/images/Stream.png")
                        enabled: true
                        onClicked: controlPanel.droneAction("stream")
                    }
                    
                    DroneButton {
                        width: (parent.width - parent.spacing * 4) / 5
                        height: parent.height
                        label: "Right"
                        iconSource: Qt.resolvedUrl("../../../../../gui/assets/images/right.png")
                        enabled: true
                        onClicked: controlPanel.droneAction("right")
                    }
                    
                    DroneButton {
                        width: (parent.width - parent.spacing * 4) / 5
                        height: parent.height
                        label: "Turn Right"
                        iconSource: Qt.resolvedUrl("../../../../../gui/assets/images/turnRight.png")
                        enabled: true
                        onClicked: controlPanel.droneAction("turn_right")
                    }
                }
                
                // Row 5: Back button
                DroneButton {
                    width: parent.width
                    height: 90
                    label: "Back"
                    iconSource: Qt.resolvedUrl("../../../../../gui/assets/images/back.png")
                    enabled: true
                    onClicked: controlPanel.droneAction("backward")
                }
                
                // Row 6: Takeoff, Down, Land
                Row {
                    width: parent.width
                    height: 75
                    spacing: 10
                    
                    DroneButton {
                        width: (parent.width - parent.spacing * 2) / 3
                        height: parent.height
                        label: "Takeoff"
                        iconSource: Qt.resolvedUrl("../../../../../gui/assets/images/takeoff.png")
                        enabled: true
                        onClicked: controlPanel.droneAction("takeoff")
                    }
                    
                    DroneButton {
                        width: (parent.width - parent.spacing * 2) / 3
                        height: parent.height
                        label: "Down"
                        iconSource: Qt.resolvedUrl("../../../../../gui/assets/images/down.png")
                        enabled: true
                        onClicked: controlPanel.droneAction("down")
                    }
                    
                    DroneButton {
                        width: (parent.width - parent.spacing * 2) / 3
                        height: parent.height
                        label: "Land"
                        iconSource: Qt.resolvedUrl("../../../../../gui/assets/images/land.png")
                        enabled: true
                        onClicked: controlPanel.droneAction("land")
                    }
                }
            }
        }
    }
    
    // Reusable Drone Button Component
    component DroneButton: Rectangle {
        id: btn
        color: btn.enabled ? "#1a2332" : "#0f1419"
        border.color: "#c0c0c0"
        border.width: 1
        radius: 6
        opacity: btn.enabled ? 1.0 : 0.4
        
        property string label: ""
        property string iconSource: ""
        property bool enabled: true
        
        signal clicked()
        
        MouseArea {
            anchors.fill: parent
            hoverEnabled: btn.enabled
            cursorShape: btn.enabled ? Qt.PointingHandCursor : Qt.ForbiddenCursor
            onEntered: {
                if (btn.enabled) {
                    parent.color = "#2a3f5f"
                    parent.border.width = 2
                }
            }
            onExited: {
                if (btn.enabled) {
                    parent.color = "#1a2332"
                    parent.border.width = 1
                }
            }
            onClicked: {
                if (btn.enabled) {
                    console.log("✅ Button clicked:", btn.label)
                    btn.clicked()
                } else {
                    console.log("⚠️ Button disabled:", btn.label, "- Connect first!")
                }
            }
        }
        
        Column {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 5
            
            Item {
                width: parent.width
                height: parent.height - labelText.height - parent.spacing
                
                Image {
                    source: btn.iconSource
                    anchors.centerIn: parent
                    width: Math.min(parent.width, parent.height) * 0.7
                    height: width
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    antialiasing: true
                    opacity: btn.enabled ? 1.0 : 0.5
                }
            }
            
            Text {
                id: labelText
                text: btn.label
                font.bold: true
                color: btn.enabled ? "#c0c0c0" : "#666666"
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                wrapMode: Text.WordWrap
                maximumLineCount: 2
                elide: Text.ElideRight
            }
        }
    }
}

