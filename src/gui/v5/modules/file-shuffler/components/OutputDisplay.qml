/*
    File Shuffler Output Display Component
    Shows console output with scrolling
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: outputDisplay
    color: "lightgrey"
    
    // Expose the output text
    property alias outputText: outputArea.text
    
    ScrollView {
        anchors.fill: parent
        clip: true
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn
        
        TextArea {
            id: outputArea
            color: "black"
            readOnly: true
            wrapMode: TextArea.Wrap
            font.pixelSize: 12
            font.family: "Courier"
            background: Rectangle {
                color: "lightgrey"
            }
        }
    }
    
    // Function to append output
    function appendOutput(text) {
        outputArea.append(text)
    }
    
    // Function to clear output
    function clearOutput() {
        outputArea.text = ""
    }
    
    // Function to set output
    function setOutput(text) {
        outputArea.text = text
    }
}

