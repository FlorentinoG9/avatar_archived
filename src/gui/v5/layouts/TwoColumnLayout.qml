/*
    TwoColumnLayout.qml
    Reusable two-column layout component
    
    Usage:
        TwoColumnLayout {
            leftWidth: 500 // or use leftRatio
            spacing: 10
            
            leftContent: YourLeftComponent { }
            rightContent: YourRightComponent { }
        }
*/

import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    
    // Properties for customization
    property int leftWidth: -1              // Fixed width for left column (-1 = use ratio)
    property real leftRatio: 0.5            // Ratio of left column (0.0 - 1.0)
    
    // Content slots
    property alias leftContent: leftContainer.data
    property alias rightContent: rightContainer.data
    
    anchors.fill: parent
    spacing: 10
    
    // Left Column
    Item {
        id: leftContainer
        Layout.preferredWidth: root.leftWidth > 0 ? root.leftWidth : parent.width * root.leftRatio
        Layout.fillHeight: true
        z: 10
        clip: true
    }
    
    // Right Column
    Item {
        id: rightContainer
        Layout.fillWidth: true
        Layout.fillHeight: true
        z: 0
        clip: true
    }
}

