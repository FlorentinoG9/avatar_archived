/*
    Ticket by Developer Log Module
    Displays scrollable ticket assignments by developer
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: ticketLog
    color: "#1A2B48"
    radius: 10
    border.color: "white"
    
    // Expose text area
    property alias ticketText: ticketTextArea.text
    
    // Ensure minimum size to prevent components from becoming too small
    Layout.minimumWidth: 200
    Layout.minimumHeight: 150
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 8
        
        Text {
            text: "Ticket by Developer Log"
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
                id: ticketTextArea
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

