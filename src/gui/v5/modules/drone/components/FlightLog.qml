/*
    Drone Flight Log Module
    Displays flight log text area
*/

import QtQuick
import QtQuick.Controls

Rectangle {
    id: flightLog
    color: "white"
    border.color: "#2E4053"
    
    // Expose the text area for external updates
    property alias logText: logArea.text
    
    Text {
        text: "Flight Log"
        font.bold: true
        font.pixelSize: Math.max(12, parent.width * 0.05)
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
    }
    
    TextArea {
        id: logArea
        anchors.fill: parent
        anchors.topMargin: 30
        font.pixelSize: Math.max(10, parent.width * 0.03)
        color: "black"
        readOnly: true
        wrapMode: TextArea.Wrap
    }
    
    // Helper function to append log messages
    function appendLog(message) {
        var timestamp = new Date().toLocaleString()
        logArea.append(message + " at " + timestamp)
    }
}

