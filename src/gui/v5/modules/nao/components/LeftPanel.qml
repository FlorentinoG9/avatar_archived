/*
    NAO Left Panel Module
    Contains control buttons grid and console log
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: leftPanel
    color: "#718399"
    radius: 6
    clip: true
    
    // Expose console logger for external access
    property alias consoleLogger: consoleLogger
    
    // Signals for button actions
    signal moveForward()
    signal moveBackward()
    signal turnLeft()
    signal turnRight()
    signal moveUp()
    signal moveDown()
    
    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: 15
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 15
        spacing: 12
        
        Label {
            text: "Nao Robot Control Panel"
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20
            font.bold: true
            color: "white"
            Layout.alignment: Qt.AlignHCenter
        }
        
        // Control buttons grid - fixed height to prevent overlap
        GridLayout {
            id: buttonGrid
            columns: 2
            columnSpacing: 15
            rowSpacing: 15
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            Layout.preferredHeight: 435
            Layout.minimumHeight: 435
            Layout.maximumHeight: 435
            
            Repeater {
                model: [
                    {label: "Backward", icon: Qt.resolvedUrl("../../../../../gui/assets/images/back.png"), signal: "moveBackward"},
                    {label: "Forward",  icon: Qt.resolvedUrl("../../../../../gui/assets/images/forward.png"), signal: "moveForward"},
                    {label: "Right",    icon: Qt.resolvedUrl("../../../../../gui/assets/images/right.png"), signal: "turnRight"},
                    {label: "Left",     icon: Qt.resolvedUrl("../../../../../gui/assets/images/left.png"), signal: "turnLeft"},
                    {label: "Takeoff",  icon: Qt.resolvedUrl("../../../../../gui/assets/images/takeoff.png"), signal: "moveUp"},
                    {label: "Land",     icon: Qt.resolvedUrl("../../../../../gui/assets/images/land.png"), signal: "moveDown"}
                ]
                
                delegate: Rectangle {
                    Layout.preferredWidth: 135
                    Layout.preferredHeight: 135
                    Layout.minimumWidth: 135
                    Layout.minimumHeight: 135
                    Layout.maximumWidth: 135
                    Layout.maximumHeight: 135
                    color: "#2c3e50"
                    radius: 10
                    
                    Column {
                        anchors.centerIn: parent
                        spacing: 8
                        
                        Image {
                            source: modelData.icon
                            width: 70
                            height: 70
                            fillMode: Image.PreserveAspectFit
                            onStatusChanged: if (status === Image.Error) console.log("❌ Image not found:", source)
                        }
                        
                        Text {
                            text: modelData.label
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                            font.pixelSize: 14
                        }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            consoleLogger.appendLog(modelData.label + " button clicked")
                            
                            // Emit appropriate signal
                            switch(modelData.signal) {
                                case "moveForward": leftPanel.moveForward(); break;
                                case "moveBackward": leftPanel.moveBackward(); break;
                                case "turnLeft": leftPanel.turnLeft(); break;
                                case "turnRight": leftPanel.turnRight(); break;
                                case "moveUp": leftPanel.moveUp(); break;
                                case "moveDown": leftPanel.moveDown(); break;
                            }
                            
                            // Also trigger backend actions
                            if (typeof backend !== "undefined") {
                                if (modelData.label === "Takeoff") {
                                    backend.nao_stand_up()
                                } else if (modelData.label === "Land") {
                                    backend.nao_sit_down()
                                }
                            }
                        }
                    }
                }
            }
        }
        
        // Console logger - fills remaining space
        ConsoleLogger {
            id: consoleLogger
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: 180
            Layout.preferredHeight: 250
            Layout.leftMargin: 12
            Layout.rightMargin: 0
        }
    }
    
    // Helper function to append to console (for backward compatibility)
    function appendLog(msg) {
        consoleLogger.appendLog(msg)
    }
}

