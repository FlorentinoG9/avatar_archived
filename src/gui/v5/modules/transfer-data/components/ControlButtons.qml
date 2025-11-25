/*
    Transfer Data Control Buttons Component
    Save Config, Load Config, Clear Config, Upload buttons
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    id: controlButtons
    spacing: 10
    
    // Signals for button actions
    signal saveConfigClicked()
    signal loadConfigClicked()
    signal clearConfigClicked()
    signal uploadClicked()
    
    Button {
        text: "Save Config"
        font.bold: true
        Layout.fillWidth: true
        implicitHeight: 45
        
        background: Rectangle {
            color: parent.pressed ? "#1a4d2e" : "#2d7a4a"
            radius: 4
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
        
        onClicked: controlButtons.saveConfigClicked()
    }
    
    Button {
        text: "Load Config"
        font.bold: true
        Layout.fillWidth: true
        implicitHeight: 45
        
        background: Rectangle {
            color: parent.pressed ? "#003366" : "#0066cc"
            radius: 4
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
        
        onClicked: controlButtons.loadConfigClicked()
    }
    
    Button {
        text: "Clear Config"
        font.bold: true
        Layout.fillWidth: true
        implicitHeight: 45
        
        background: Rectangle {
            color: parent.pressed ? "#8b4513" : "#cd853f"
            radius: 4
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
        
        onClicked: controlButtons.clearConfigClicked()
    }
    
    Button {
        text: "Upload"
        font.bold: true
        Layout.fillWidth: true
        implicitHeight: 45
        
        background: Rectangle {
            color: parent.pressed ? "#660066" : "#9933cc"
            radius: 4
            border.color: "#cc66ff"
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
        
        onClicked: controlButtons.uploadClicked()
    }
}

