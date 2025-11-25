/*
    NAO Connection Card Module
    Floating card with IP/Port configuration and connect button
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: connectionCard
    
    width: parent.width * 0.25
    height: parent.height * 0.25
    color: "#242c4d"
    radius: 8
    border.color: "#3a4a6d"
    border.width: 2
    
    // Expose input values
    property alias ipAddress: ipInput.text
    property alias port: portInput.text
    
    // Signal when connect button is clicked
    signal connectClicked(string ip, string port)
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 10
        
        Text {
            text: "NAO Connection"
            font.pixelSize: 14
            font.bold: true
            color: "white"
            Layout.alignment: Qt.AlignHCenter
        }
        
        // IP Address Input
        RowLayout {
            Layout.fillWidth: true
            spacing: 8
            
            Text {
                text: "IP:"
                color: "white"
                font.pixelSize: 12
                Layout.preferredWidth: 30
            }
            
            TextField {
                id: ipInput
                Layout.fillWidth: true
                placeholderText: "192.168.23.53"
                text: "192.168.23.53"
                font.pixelSize: 11
                background: Rectangle {
                    color: "#1a1f3a"
                    border.color: "#4a5a7d"
                    border.width: 1
                    radius: 4
                }
                color: "white"
            }
        }
        
        // Port Input
        RowLayout {
            Layout.fillWidth: true
            spacing: 8
            
            Text {
                text: "Port:"
                color: "white"
                font.pixelSize: 12
                Layout.preferredWidth: 30
            }
            
            TextField {
                id: portInput
                Layout.fillWidth: true
                placeholderText: "9559"
                text: "9559"
                font.pixelSize: 11
                background: Rectangle {
                    color: "#1a1f3a"
                    border.color: "#4a5a7d"
                    border.width: 1
                    radius: 4
                }
                color: "white"
            }
        }
        
        // Connect Button
        Button {
            Layout.fillWidth: true
            Layout.preferredHeight: 36
            text: "Connect"
            font.bold: true
            font.pixelSize: 12
            
            background: Rectangle {
                color: parent.pressed ? "#1a4d2e" : "#2d7a4a"
                radius: 4
                border.color: "#4a9d6f"
                border.width: 1
            }
            
            contentItem: Text {
                text: parent.text
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font: parent.font
            }
            
            onClicked: {
                var ip = ipInput.text.trim()
                var port = portInput.text.trim()
                connectionCard.connectClicked(ip, port)
                
                // Also call backend if available
                if (typeof backend !== "undefined" && backend.connectNao) {
                    backend.connectNao(ip, port)
                }
            }
        }
    }
}

