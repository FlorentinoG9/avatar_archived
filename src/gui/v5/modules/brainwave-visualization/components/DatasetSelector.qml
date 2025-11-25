/*
    Brainwave Dataset Selector Module
    Refresh and Rollback buttons for dataset selection
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    id: datasetSelector
    
    Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
    Layout.bottomMargin: 20
    spacing: 15
    
    // Signals
    signal refreshClicked()
    signal rollbackClicked()
    
    // Refresh Button
    Button {
        text: "Refresh"
        font.bold: true
        implicitWidth: 120
        implicitHeight: 40
        property bool isHovering: false
        
        HoverHandler { onHoveredChanged: parent.isHovering = hovered }
        
        background: Rectangle {
            color: parent.isHovering ? "#3e4e7a" : "#2e3a5c"
            radius: 4
            
            Behavior on color { 
                ColorAnimation { 
                    duration: 150 
                } 
            }
        }
        
        contentItem: Text {
            text: parent.text
            font.pixelSize: 14
            font.bold: true
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        
        onClicked: datasetSelector.refreshClicked()
    }
    
    // Rollback Button
    Button {
        text: "Rollback"
        font.bold: true
        implicitWidth: 120
        implicitHeight: 40
        property bool isHovering: false
        
        HoverHandler { 
            onHoveredChanged: parent.isHovering = hovered 
        }
        
        background: Rectangle {
            color: parent.isHovering ? "#3e4e7a" : "#2e3a5c"
            radius: 4
            
            Behavior on color { 
                ColorAnimation { 
                    duration: 150 
                } 
            }
        }
        
        contentItem: Text {
            text: parent.text
            font.pixelSize: 14
            font.bold: true
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        
        onClicked: datasetSelector.rollbackClicked()
    }
}

