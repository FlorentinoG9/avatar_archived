/*
    Transfer Data Connection Form Component
    Contains IP, username, password, and key configuration
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

ColumnLayout {
    id: connectionForm
    spacing: 10
    
    // Expose form field values
    property alias targetIP: ipField.text
    property alias targetUsername: usernameField.text
    property alias targetPassword: passwordField.text
    property alias privateKeyDir: privateKeyField.text
    property alias ignoreHostKey: ignoreHostKeyCheckbox.checked
    
    // Target IP
    Label {
        text: "Target IP"
        color: "white"
        font.bold: true
        font.pixelSize: 14
    }
    
    TextField {
        id: ipField
        Layout.fillWidth: true
        implicitHeight: 36
        placeholderText: "192.168.1.100"
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
    
    // Target Username
    Label {
        text: "Target Username"
        color: "white"
        font.bold: true
        font.pixelSize: 14
    }
    
    TextField {
        id: usernameField
        Layout.fillWidth: true
        implicitHeight: 36
        placeholderText: "user"
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
    
    // Target Password
    Label {
        text: "Target Password"
        color: "white"
        font.bold: true
        font.pixelSize: 14
    }
    
    TextField {
        id: passwordField
        Layout.fillWidth: true
        implicitHeight: 36
        echoMode: TextInput.Password
        placeholderText: "••••••••"
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
    
    // Private Key Directory
    Label {
        text: "Private Key Directory:"
        color: "white"
        font.bold: true
        font.pixelSize: 14
    }
    
    RowLayout {
        Layout.fillWidth: true
        spacing: 8
        
        TextField {
            id: privateKeyField
            Layout.fillWidth: true
            implicitHeight: 36
            placeholderText: "/path/to/private/key"
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
            
            onClicked: privateKeyDialog.open()
        }
    }
    
    // Ignore Host Key Checkbox
    CheckBox {
        id: ignoreHostKeyCheckbox
        text: "Ignore Host Key"
        font.bold: true
        checked: true
        
        contentItem: Text {
            text: parent.text
            font.bold: true
            color: "white"
            leftPadding: parent.indicator.width + parent.spacing
            verticalAlignment: Text.AlignVCenter
        }
    }
    
    // File Dialog for Private Key
    FileDialog {
        id: privateKeyDialog
        title: "Select Private Key File"
        currentFolder: "file:///" + (privateKeyField.text || "~")
        fileMode: FileDialog.OpenFile
        nameFilters: ["All files (*)"]
        
        onAccepted: {
            privateKeyField.text = selectedFile.toString().replace("file://", "")
        }
    }
}

