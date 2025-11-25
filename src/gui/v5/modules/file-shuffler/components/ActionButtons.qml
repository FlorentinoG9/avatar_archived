/*
    File Shuffler Action Buttons Component
    Contains the three main action buttons
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Row {
    id: actionButtons
    spacing: 20
    
    // Signals for button actions
    signal unifyThoughtsClicked()
    signal remove8ChannelClicked()
    signal runShufflerClicked()
    
    Button {
        text: "Unify Thoughts"
        font.bold: true
        implicitWidth: 180
        implicitHeight: 45
        
        background: Rectangle {
            color: parent.pressed ? "#1a4d2e" : "#2d7a4a"
            radius: 5
            border.color: "#4a9d6f"
            border.width: 1
        }
        
        contentItem: Text {
            text: parent.text
            color: "white"
            font.bold: true
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        
        onClicked: actionButtons.unifyThoughtsClicked()
    }
    
    Button {
        text: "Remove 8 Channel Data"
        font.bold: true
        implicitWidth: 180
        implicitHeight: 45
        
        background: Rectangle {
            color: parent.pressed ? "#8b4513" : "#cd853f"
            radius: 5
            border.color: "#daa520"
            border.width: 1
        }
        
        contentItem: Text {
            text: parent.text
            color: "white"
            font.bold: true
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        
        onClicked: actionButtons.remove8ChannelClicked()
    }
    
    Button {
        text: "Run File Shuffler"
        font.bold: true
        implicitWidth: 180
        implicitHeight: 45
        
        background: Rectangle {
            color: parent.pressed ? "#003366" : "#0066cc"
            radius: 5
            border.color: "#4da6ff"
            border.width: 1
        }
        
        contentItem: Text {
            text: parent.text
            color: "white"
            font.bold: true
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        
        onClicked: actionButtons.runShufflerClicked()
    }
}

