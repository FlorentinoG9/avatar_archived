/*
    Medal Display Module
    Displays medal image with refresh button
*/

import QtQuick
import QtQuick.Controls

Rectangle {
    id: medalDisplay
    color: "#718399"
    radius: 10
    border.color: "transparent"
    
    // Signal when refresh is clicked
    signal refreshClicked()
    
    Column {
        anchors.centerIn: parent
        spacing: 10
        
        // Medal Image
        Image {
            source: Qt.resolvedUrl("../../../../../gui/assets/developers/Medal.png")
            width: 200
            height: 280
            fillMode: Image.PreserveAspectFit
            smooth: true
            antialiasing: true
            anchors.horizontalCenter: parent.horizontalCenter
        }
        
        // Refresh Button
        Button {
            text: "Refresh"
            font.bold: true
            width: 180
            height: 45
            anchors.horizontalCenter: parent.horizontalCenter
            
            background: Rectangle {
                color: "#003366"
                radius: 5
                border.color: "#001F3F"
            }
            
            contentItem: Text {
                text: qsTr("Refresh")
                font.bold: true
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            
            onClicked: medalDisplay.refreshClicked()
        }
    }
}

