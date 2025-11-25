/*
    Brainwave Flight Log Module
    Displays flight log for brainwave commands
*/

import QtQuick
import QtQuick.Controls

GroupBox {
    id: flightLog
    title: "Flight Log"
    
    label: Text { 
        text: qsTr("Flight Log")
        font.bold: true
        color: "white" 
    }
    
    Rectangle {
        anchors.fill: parent
        color: "white"
        
        ListView {
            id: flightLogView
            anchors.fill: parent
            model: ListModel {}
            delegate: Text {
                text: log
                font.pixelSize: parent.width * 0.03
                font.bold: true
                color: "white"
            }
        }
    }
    
    // Function to add log entry
    function addLog(message) {
        flightLogView.model.insert(0, {"log": message})
    }
    
    // Function to clear log
    function clearLog() {
        flightLogView.model.clear()
    }
}

