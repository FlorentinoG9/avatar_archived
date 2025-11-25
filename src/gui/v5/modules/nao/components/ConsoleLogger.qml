/*
    Console Logger Component for NAO
    Displays system logs with timestamps
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: consoleLogger
    color: "#2a3f5f"
    radius: 6
    
    // Expose the log text
    property alias logText: logArea.text
    
    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: 15
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        spacing: 10
       
        
        Text {
            text: "Console Logger"
            color: "#c0c0c0"
            font.bold: true
            font.pixelSize: 18
            Layout.alignment: Qt.AlignLeft
            leftPadding: 15
            height: 20
        }
        
        ScrollView {
            id: scrollView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            
            TextArea {
                id: logArea
                readOnly: true
                wrapMode: TextArea.Wrap
                color: "white"
                font.pixelSize: 12
                font.family: "Courier"
                background: Rectangle {
                    color: "#1a2332"
                }
                
                // Initialize with some default logs
                text: "[" + Qt.formatTime(new Date(), "hh:mm:ss AP") + "] System initialized\n" +
                      "[" + Qt.formatTime(new Date(), "hh:mm:ss AP") + "] NAO connection ready\n" +
                      "[" + Qt.formatTime(new Date(), "hh:mm:ss AP") + "] Awaiting connection..."
                
                // Auto-scroll to bottom when text changes
                onTextChanged: {
                    logArea.cursorPosition = logArea.length
                    scrollView.ScrollBar.vertical.position = 1.0 - scrollView.ScrollBar.vertical.size
                }
            }
        }
    }
    
    // Function to append log messages with timestamp
    function appendLog(message) {
        var timestamp = Qt.formatTime(new Date(), "hh:mm:ss AP")
        logArea.append("[" + timestamp + "] " + message)
        
        // Auto-scroll to bottom
        Qt.callLater(function() {
            logArea.cursorPosition = logArea.length
            scrollView.ScrollBar.vertical.position = 1.0 - scrollView.ScrollBar.vertical.size
        })
    }
    
    // Function to clear logs
    function clearLog() {
        logArea.text = ""
    }
}

