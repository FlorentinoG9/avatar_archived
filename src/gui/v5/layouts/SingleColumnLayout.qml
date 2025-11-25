/*
    SingleColumnLayout.qml
    Reusable single-column layout component with optional header/footer
    
    Usage:
        SingleColumnLayout {
            spacing: 10
            
            header: HeaderComponent { }
            content: MainContent { }
            footer: FooterComponent { }
        }
*/

import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root
    
    // Properties
    property int headerHeight: -1    // Auto if -1
    property int footerHeight: -1    // Auto if -1
    
    // Content slots
    property alias header: headerContainer.data
    property alias content: contentContainer.data
    property alias footer: footerContainer.data
    
    anchors.fill: parent
    spacing: 10
    
    // Header (optional)
    Item {
        id: headerContainer
        Layout.fillWidth: true
        Layout.preferredHeight: root.headerHeight > 0 ? root.headerHeight : childrenRect.height
        visible: children.length > 0
    }
    
    // Main Content
    Item {
        id: contentContainer
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
    
    // Footer (optional)
    Item {
        id: footerContainer
        Layout.fillWidth: true
        Layout.preferredHeight: root.footerHeight > 0 ? root.footerHeight : childrenRect.height
        visible: children.length > 0
    }
}

