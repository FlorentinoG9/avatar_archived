/*
    GridLayout.qml
    Reusable grid layout component
    
    Usage:
        GridLayout {
            columns: 3
            rows: 2
            columnSpacing: 10
            rowSpacing: 10
            
            content: [
                Component1 { },
                Component2 { },
                Component3 { }
            ]
        }
*/

import QtQuick
import QtQuick.Layouts as QL

Item {
    id: root
    
    // Properties
    property int columns: 3
    property int rows: 2
    property int columnSpacing: 10
    property int rowSpacing: 10
    property alias content: gridContainer.data
    
    anchors.fill: parent
    
    QL.GridLayout {
        id: gridContainer
        anchors.fill: parent
        columns: root.columns
        columnSpacing: root.columnSpacing
        rowSpacing: root.rowSpacing
    }
}

