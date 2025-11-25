/*
    Three Column Layout
    Divides viewport into three columns with customizable widths
*/

import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    
    // Properties for column widths
    property real leftRatio: 0.25       // Default 25% for left column
    property real centerRatio: 0.50     // Default 50% for center column
    // Right column takes remaining space
    
    // Content slots
    property alias leftContent: leftContainer.data
    property alias centerContent: centerContainer.data
    property alias rightContent: rightContainer.data
    
    anchors.fill: parent
    spacing: 10
    
    // Left Column
    Item {
        id: leftContainer
        Layout.preferredWidth: parent.width * root.leftRatio
        Layout.fillHeight: true
    }
    
    // Center Column
    Item {
        id: centerContainer
        Layout.preferredWidth: parent.width * root.centerRatio
        Layout.fillHeight: true
    }
    
    // Right Column
    Item {
        id: rightContainer
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}

