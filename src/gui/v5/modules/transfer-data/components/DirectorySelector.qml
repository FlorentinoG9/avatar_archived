/*
    Transfer Data Directory Selector Component
    Source and target directory selection
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

ColumnLayout {
    id: directorySelector
    spacing: 10
    
    // Expose directory values
    property alias sourceDirectory: sourceDirField.text
    property alias targetDirectory: targetDirField.text
    
    // Source Directory
    Label {
        text: "Source Directory:"
        color: "white"
        font.bold: true
        font.pixelSize: 14
    }
    
    RowLayout {
        Layout.fillWidth: true
        spacing: 8
        
        TextField {
            id: sourceDirField
            Layout.fillWidth: true
            implicitHeight: 36
            placeholderText: "/path/to/source"
            font.pixelSize: 14
            leftPadding: 10
            rightPadding: 10
            topPadding: 5
            bottomPadding: 5
            background: Rectangle {
                color: '#444b6a'
                border.color: '#272b3d'
                border.width: 0.5
                radius: 4
            }
            color: "white"
            verticalAlignment: TextInput.AlignVCenter
        }
        
        Button {
            text: "Browse"
            font.bold: true
            implicitHeight: 36
            implicitWidth: 100
            
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
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            
            onClicked: sourceDirDialog.open()
        }
    }
    
    // Target Directory
    Label {
        text: "Target Directory:"
        color: "white"
        font.bold: true
        font.pixelSize: 14
    }
    
    TextField {
        id: targetDirField
        Layout.fillWidth: true
        implicitHeight: 36
        text: "/home/"
        placeholderText: "/home/"
        font.pixelSize: 14
        leftPadding: 10
        rightPadding: 10
        topPadding: 5
        bottomPadding: 5
        background: Rectangle {
            color: '#444b6a'
            border.color: '#272b3d'
            border.width: 0.5
            radius: 4
        }
        color: "white"
        verticalAlignment: TextInput.AlignVCenter
    }
    
    // Folder Dialog for Source Directory
    FolderDialog {
        id: sourceDirDialog
        title: "Select Source Directory"
        currentFolder: "file:///" + (sourceDirField.text || "~")
        
        onAccepted: {
            sourceDirField.text = selectedFolder.toString().replace("file://", "")
        }
    }
}

