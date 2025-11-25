/*
    File Shuffler Status Indicators Component
    Shows completion status for different operations
*/

import QtQuick
import QtQuick.Layouts

Column {
    id: statusIndicators
    spacing: 10
    
    // Status properties
    property bool shuffleComplete: false
    property bool thoughtsUnified: false
    property bool channelRemoved: false
    
    Text {
        id: shuffleText
        text: "✓ Shuffle Complete!"
        color: "yellow"
        font.bold: true
        font.pixelSize: 18
        visible: statusIndicators.shuffleComplete
        anchors.horizontalCenter: parent.horizontalCenter
    }
    
    Text {
        id: unifiedText
        text: "✓ Thoughts Unified!"
        color: "lightgreen"
        font.bold: true
        font.pixelSize: 18
        visible: statusIndicators.thoughtsUnified
        anchors.horizontalCenter: parent.horizontalCenter
    }
    
    Text {
        id: channelText
        text: "✓ 8 Channel Data Removed!"
        color: "lightblue"
        font.bold: true
        font.pixelSize: 18
        visible: statusIndicators.channelRemoved
        anchors.horizontalCenter: parent.horizontalCenter
    }
    
    // Helper functions
    function reset() {
        shuffleComplete = false
        thoughtsUnified = false
        channelRemoved = false
    }
    
    function setShuffleComplete(value) {
        shuffleComplete = value
    }
    
    function setThoughtsUnified(value) {
        thoughtsUnified = value
    }
    
    function setChannelRemoved(value) {
        channelRemoved = value
    }
}

