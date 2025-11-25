/*
    Developers Log Module
    Displays scrollable developer list
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: devLog
    color: "#1A2B48"
    radius: 10
    border.color: "white"
    
    // Expose text area
    property alias devText: devTextArea.text
    
    // Ensure minimum size to prevent components from becoming too small
    Layout.minimumWidth: 200
    Layout.minimumHeight: 150
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 8
        
        Text {
            text: "Developers Log"
            color: "white"
            font.bold: true
            font.pixelSize: 22
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }
        
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            
            TextArea {
                id: devTextArea
                text: "Console output here..."
                readOnly: true
                wrapMode: TextArea.Wrap
                font.pixelSize: 12
                color: "black"
                background: Rectangle { 
                    color: "white"
                    radius: 6 
                }
            }
        }
    }
}

