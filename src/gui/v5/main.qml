import QtQuick 6.5
import QtQuick.Controls 6.4
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import QtQuick3D 6.7
import QtQuick.Dialogs
import Qt.labs.platform

ApplicationWindow {
    visible: true
    width: 1200
    height: 800
    title: "Avatar - BCI"

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // ===== TOP TAB BAR =====
        TabBar {
            id: topTabBar
            Layout.fillWidth: true
            height: 60

            TabButton {
                text: "Brainwave Reading"
                font.bold: true
                checked: stackLayout.currentIndex === 0
                height: parent.height
                onClicked: stackLayout.currentIndex = 0
                
                background: Rectangle {
                    color: parent.checked ? "#D3D3D3" : "transparent"
                    anchors.fill: parent
                }
                
                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    color: parent.checked ? "black" : "#666666"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            TabButton {
                text: "Manual Drone Control"
                font.bold: true
                checked: stackLayout.currentIndex === 2
                height: parent.height
                onClicked: stackLayout.currentIndex = 2
                
                background: Rectangle {
                    color: parent.checked ? "#D3D3D3" : "transparent"
                    anchors.fill: parent
                }
                
                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    color: parent.checked ? "black" : "#666666"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            TabButton {
                text: "Manual NAO Control"
                font.bold: true
                checked: stackLayout.currentIndex === 3
                height: parent.height
                onClicked: {
                    stackLayout.currentIndex = 3
                    console.log("Manual Controller tab clicked")
                }
                
                background: Rectangle {
                    color: parent.checked ? "#D3D3D3" : "transparent"
                    anchors.fill: parent
                }
                
                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    color: parent.checked ? "black" : "#666666"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }

        // ===== MAIN STACK LAYOUT =====
        StackLayout {
            id: stackLayout
            Layout.fillWidth: true
            Layout.fillHeight: true

            // View 0: Brainwave Reading
            Loader { 
                Layout.fillWidth: true
                Layout.fillHeight: true
                source: "modules/brainwave/view.qml"
            }
            
            // View 1: Brainwave Visualization
            Loader { 
                Layout.fillWidth: true
                Layout.fillHeight: true
                source: "modules/brainwave-visualization/view.qml"
            }
            
            // View 2: Drone Control
            Loader { 
                Layout.fillWidth: true
                Layout.fillHeight: true
                source: "modules/drone/view.qml"
            }
            
            // View 3: NAO Control
            Loader { 
                Layout.fillWidth: true
                Layout.fillHeight: true
                source: "modules/nao/view.qml"
            }
            
            // View 4: File Shuffler (using legacy layout)
            Loader { 
                Layout.fillWidth: true
                Layout.fillHeight: true
                source: "modules/file-shuffler/view.qml"
            }
            
            // View 5: Transfer Data (using legacy layout)
            Loader { 
                Layout.fillWidth: true
                Layout.fillHeight: true
                source: "modules/transfer-data/view.qml"
            }
            
            // View 6: Developers
            Loader { 
                Layout.fillWidth: true
                Layout.fillHeight: true
                source: "modules/developers/view.qml"
            }
        }

        // ===== BOTTOM TAB BAR =====
        TabBar {
            id: bottomTabBar
            Layout.fillWidth: true
            height: 60
            position: TabBar.Footer

            TabButton {
                text: "Brainwave Visualization"
                font.bold: true
                checked: stackLayout.currentIndex === 1
                height: parent.height
                onClicked: stackLayout.currentIndex = 1
                
                background: Rectangle {
                    color: parent.checked ? "#D3D3D3" : "transparent"
                    anchors.fill: parent
                }
                
                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    color: parent.checked ? "black" : "#666666"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            TabButton {
                text: "File Shuffler"
                font.bold: true
                checked: stackLayout.currentIndex === 4
                height: parent.height
                onClicked: stackLayout.currentIndex = 4
                
                background: Rectangle {
                    color: parent.checked ? "#D3D3D3" : "transparent"
                    anchors.fill: parent
                }
                
                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    color: parent.checked ? "black" : "#666666"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            TabButton {
                text: "Transfer Data"
                font.bold: true
                checked: stackLayout.currentIndex === 5
                height: parent.height
                onClicked: stackLayout.currentIndex = 5
                
                background: Rectangle {
                    color: parent.checked ? "#D3D3D3" : "transparent"
                    anchors.fill: parent
                }
                
                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    color: parent.checked ? "black" : "#666666"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            TabButton {
                text: "Developers"
                font.bold: true
                checked: stackLayout.currentIndex === 6
                height: parent.height
                onClicked: stackLayout.currentIndex = 6
                
                background: Rectangle {
                    color: parent.checked ? "#D3D3D3" : "transparent"
                    anchors.fill: parent
                }
                
                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    color: parent.checked ? "black" : "#666666"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
}
