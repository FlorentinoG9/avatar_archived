/*
    Brainwave Predictions Table Module
    Displays prediction count, server, and label in ASCII/Markdown table format
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: predictionsTable
    color: "#2a3f5f"
    
    property var tableModel: ListModel {
        ListElement { 
            count: "1"
            server: "Prediction A"
            label: "Label A" 
        }
        ListElement { 
            count: "2"
            server: "Prediction B"
            label: "Label B" 
        }
    }
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 10
        
        Text {
            text: "Predictions Table"
            color: "#c0c0c0"
            font.bold: true
            font.pixelSize: 18
            Layout.alignment: Qt.AlignLeft
        }
        
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            
            TextArea {
                id: tableDisplay
                readOnly: true
                wrapMode: TextArea.NoWrap
                color: "white"
                font.pixelSize: 12
                font.family: "Courier"
                background: Rectangle {
                    color: "#1a2332"
                }
                
                text: generateAsciiTable()
            }
        }
    }
    
    // Function to generate ASCII table with balanced columns
    function generateAsciiTable() {
        var result = "";
        
        // Balanced widths
        var countWidth = 5;
        var serverWidth = 18;
        var labelWidth = 14;
        
        // Header
        result += "┌───────┬────────────────────┬────────────────┐\n";
        result += "│ Count │ Server             │ Label          │\n";
        result += "├───────┼────────────────────┼────────────────┤\n";
        
        // Data rows
        for (var i = 0; i < tableModel.count; i++) {
            var item = tableModel.get(i);
            // Auto-generate row number (i + 1)
            var countStr = padString((i + 1).toString(), countWidth);
            var serverStr = padString(item.server, serverWidth);
            var labelStr = padString(item.label, labelWidth);
            
            result += "│ " + countStr + " │ " + serverStr + " │ " + labelStr + " │\n";
        }
        
        // Footer
        result += "└───────┴────────────────────┴────────────────┘";
        
        return result;
    }
    
    // Helper function to pad strings
    function padString(str, length) {
        var s = str.toString()
        while (s.length < length) {
            s += " "
        }
        return s.substring(0, length)
    }
    
    // Function to refresh table display
    function refreshTable() {
        tableDisplay.text = generateAsciiTable()
    }
    
    // Function to add a prediction
    function addPrediction(count, server, label) {
        // Count is auto-generated from row index, so we don't store it
        tableModel.append({
            "server": server,
            "label": label
        })
        refreshTable()
    }
    
    // Function to clear predictions
    function clearPredictions() {
        tableModel.clear()
        refreshTable()
    }
}

