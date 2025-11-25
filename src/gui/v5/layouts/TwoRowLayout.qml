/*
    TwoRowLayout.qml
    Reusable two-row layout component
    
    Usage:
        TwoRowLayout {
            topHeight: 300 // or use topRatio
            spacing: 20
            
            topContent: TopComponent { }
            bottomContent: BottomComponent { }
        }
*/

import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root
    
    // Properties for customization
    property int topHeight: -1               // Fixed height for top row (-1 = use ratio)
    property real topRatio: 0.5              // Ratio of top row (0.0 - 1.0)
    
    // Content slots
    property alias topContent: topContainer.data
    property alias bottomContent: bottomContainer.data
    
    anchors.fill: parent
    spacing: 20
    
    // Ensure content doesn't overflow
    clip: true
    
    // Top Row
    Item {
        id: topContainer
        Layout.fillWidth: true
        Layout.preferredHeight: root.topHeight > 0 ? root.topHeight : parent.height * root.topRatio
    }
    
    // Bottom Row
    Item {
        id: bottomContainer
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}

