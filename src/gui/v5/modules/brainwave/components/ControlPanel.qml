/*
    Brainwave Control Panel Module
    Left side panel with brain reading, model selection, and controls
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: controlPanelRoot
    anchors.fill: parent
    z: 10
    
    // Expose signals from inner Column
    signal readMyMind()
    signal executeAction()
    signal notWhatIWasThinking(string action)
    signal connectDrone()
    signal keepDroneAlive()
    signal modelSelected(string modelName)
    signal frameworkSelected(string frameworkName)
    signal dataModeChanged(string mode)
    
    // Expose properties from inner Column
    property bool isRandomForestSelected: false
    property bool isPyTorchSelected: true
    
    Column {
        id: controlPanel
        width: parent.width
        anchors.centerIn: parent
        spacing: 10
    
    // Top Section: Brain Button + Radio Buttons (LEFT) | Model Predictions Table (RIGHT)
    Row {
        width: parent.width * 0.9
        height: parent.height * 0.44
        spacing: 15
        anchors.horizontalCenter: parent.horizontalCenter
        
        // LEFT COLUMN: Brain Button + Radio Buttons
        Column {
            width: parent.width * 0.45
            height: parent.height
            spacing: 10
            
            // Brain Image Button
            Rectangle {
                width: parent.width
                height: (parent.height - 10) * 0.6
                color: "#242c4d"
                radius: 5
                
                // Row to align icon and text together
                Row {
                    anchors.centerIn: parent
                    spacing: 10
                    
                    // Brain icon
                    Image {
                        source: Qt.resolvedUrl("../../../../../gui/assets/images/brain.png")
                        width: 40
                        height: 40
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    
                    // "Read my mind" text
                    Text {
                        text: "Read my mind"
                        font.pixelSize: 16
                        font.bold: true
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: controlPanelRoot.readMyMind()
                }
            }
            
            // Control Mode Selection (Radio Buttons)
            Row {
                width: parent.width
                spacing: 15
                anchors.horizontalCenter: parent.horizontalCenter
                
                RadioButton {
                    id: manualControl
                    text: "Manual Control"
                    checked: true
                    font.pixelSize: 14
                    
                    contentItem: Text {
                        text: manualControl.text
                        color: "white"
                        font.pixelSize: 14
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: manualControl.indicator.width + manualControl.spacing
                    }
                }
                
                RadioButton {
                    id: autopilot
                    text: "Autopilot"
                    font.pixelSize: 14
                    
                    contentItem: Text {
                        text: autopilot.text
                        color: "white"
                        font.pixelSize: 14
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: autopilot.indicator.width + autopilot.spacing
                    }
                }
            }
        }
        
        // RIGHT COLUMN: Model Predictions Panel (spans full height)
        Rectangle {
            width: parent.width * 0.53
            height: parent.height
            color: "#5a6a7a"
            radius: 5
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 5
                
                // "The model says ..." Label
                Label {
                    text: "The model says ..."
                    color: "white"
                    font.pixelSize: 14
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }
                
                // Predictions Table Headers
                Row {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 25
                    spacing: 2
                    
                    Rectangle {
                        color: "white"
                        width: parent.width * 0.5
                        height: parent.height
                        
                        Text {
                            text: "Count"
                            font.bold: true
                            font.pixelSize: 12
                            color: "black"
                            anchors.centerIn: parent
                        }
                    }
                    
                    Rectangle {
                        color: "white"
                        width: parent.width * 0.5
                        height: parent.height
                        
                        Text {
                            text: "Label"
                            font.bold: true
                            font.pixelSize: 12
                            color: "black"
                            anchors.centerIn: parent
                        }
                    }
                }
                
                // Empty space for predictions (data area)
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#4a5a6a"
                    radius: 3
                }
            }
        }
    }
    
    // Action Buttons Row: "Not what I was thinking..." + "Execute"
    Row {
        width: parent.width * 0.9
        height: 40
        spacing: 15
        anchors.horizontalCenter: parent.horizontalCenter
        
        Button {
            id: notThinking
            text: "Not what I was thinking..."
            font.pixelSize: 14
            width: parent.width * 0.45
            height: parent.height
            background: Rectangle { 
                color: "#242c4d"
                radius: 5
            }
            contentItem: Text {
                text: notThinking.text
                color: "white"
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            onClicked: controlPanelRoot.notWhatIWasThinking(manualInput.text)
        }
        
        Button {
            id: executeBtn
            text: "Execute"
            font.pixelSize: 14
            width: parent.width * 0.53
            height: parent.height
            background: Rectangle { 
                color: "#242c4d"
                radius: 5
            }
            contentItem: Text {
                text: executeBtn.text
                color: "white"
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            onClicked: controlPanelRoot.executeAction()
        }
    }
    
    // Manual Command Input + Keep Drone Alive Button
    Row {
        width: parent.width * 0.9
        height: 35
        spacing: 15
        anchors.horizontalCenter: parent.horizontalCenter
        
        TextField {
            id: manualInput
            placeholderText: "Enter command..."
            font.pixelSize: 14
            width: (parent.width - parent.spacing) * 0.67
            height: parent.height
            leftPadding: 10
            rightPadding: 10
            topPadding: 5
            bottomPadding: 5
            background: Rectangle {
                color: '#444b6a'
                border.color: '#272b3d'
                border.width: 0.5
                radius: 4
                
            }
            color: "white"
            verticalAlignment: TextInput.AlignVCenter
        }
        
        Button {
            width: (parent.width - parent.spacing) * 0.33
            height: parent.height
            background: Rectangle { 
                color: "#242c4d"
                radius: 5
            }
            contentItem: Text {
                text: "Keep Drone Alive"
                color: "white"
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
            }
            onClicked: controlPanelRoot.keepDroneAlive()
        }
    }
    
    // Connect Button and Data Mode Row
    Row {
        width: parent.width * 0.9
        height: 50
        spacing: 15
        anchors.horizontalCenter: parent.horizontalCenter
        
        // Connect Button
        Rectangle {
            width: parent.width * 0.3
            height: parent.height
            color: "#242c4d"
            radius: 5
            
            Row {
                anchors.centerIn: parent
                spacing: 8
                
                Image {
                    source: Qt.resolvedUrl("../../../../../gui/assets/images/connect.png")
                    width: 24
                    height: 24
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: parent.verticalCenter
                }
                
                Text {
                    text: "Connect"
                    font.pixelSize: 14
                    font.bold: true
                    color: "white"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: controlPanelRoot.connectDrone()
            }
        }
        
        // Data Mode Selection (on the right)
        Row {
            width: parent.width * 0.5
            height: parent.height
            spacing: 15
            anchors.verticalCenter: parent.verticalCenter
            
            RadioButton {
                id: syntheticRadio
                text: "Synthetic Data"
                font.pixelSize: 12
                font.bold: true
                checked: false
                anchors.verticalCenter: parent.verticalCenter
                contentItem: Text {
                    text: syntheticRadio.text
                    color: "white"
                    font.pixelSize: 12
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: syntheticRadio.indicator.width + syntheticRadio.spacing
                }
                onClicked: controlPanelRoot.dataModeChanged("synthetic")
            }
            
            RadioButton {
                id: liveRadio
                text: "Live Data"
                font.pixelSize: 12
                font.bold: true
                checked: true
                anchors.verticalCenter: parent.verticalCenter
                contentItem: Text {
                    text: liveRadio.text
                    color: "white"
                    font.pixelSize: 12
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: liveRadio.indicator.width + liveRadio.spacing
                }
                onClicked: controlPanelRoot.dataModeChanged("live")
            }
        }
    }
    
        // Model and Framework Selection
        ColumnLayout {
            width: parent.width * 0.9
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            
            // Model Selection Section
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 5
                
                // "Model" Label
                Text {
                    text: "Model"
                    color: "#c0c0c0"
                    font.pixelSize: 16
                    font.bold: true
                    Layout.alignment: Qt.AlignLeft
                }
                
                // Model Buttons Row
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    
                            // Random Forest Button
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        color: "#6eb109"
                        radius: 5
                        opacity: controlPanelRoot.isRandomForestSelected ? 1.0 : 0.5
                        border.color: controlPanelRoot.isRandomForestSelected ? "yellow" : "transparent"
                        border.width: controlPanelRoot.isRandomForestSelected ? 3 : 0
                        
                        Text {
                            text: "Random Forest"
                            font.pixelSize: 14
                            font.bold: true
                            color: controlPanelRoot.isRandomForestSelected ? "yellow" : "white"
                            anchors.centerIn: parent
                        }
                        
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                controlPanelRoot.isRandomForestSelected = true
                                controlPanelRoot.modelSelected("Random Forest")
                            }
                        }
                        
                        Behavior on opacity {
                            NumberAnimation { duration: 200 }
                        }
                    }
                    
                    // Deep Learning Button
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        color: "#6eb109"
                        radius: 5
                        opacity: !controlPanelRoot.isRandomForestSelected ? 1.0 : 0.5
                        border.color: !controlPanelRoot.isRandomForestSelected ? "yellow" : "transparent"
                        border.width: !controlPanelRoot.isRandomForestSelected ? 3 : 0
                        
                        Text {
                            text: "Deep Learning"
                            font.pixelSize: 14
                            font.bold: true
                            color: !controlPanelRoot.isRandomForestSelected ? "yellow" : "white"
                            anchors.centerIn: parent
                        }
                        
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                controlPanelRoot.isRandomForestSelected = false
                                controlPanelRoot.modelSelected("Deep Learning")
                            }
                        }
                        
                        Behavior on opacity {
                            NumberAnimation { duration: 200 }
                        }
                    }
                }
            }
            
            // Framework Selection Section
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 5
                
                // "Framework" Label
                Text {
                    text: "Framework"
                    color: "#c0c0c0"
                    font.pixelSize: 16
                    font.bold: true
                    Layout.alignment: Qt.AlignLeft
                }
                
                // Framework Buttons Row
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    
                    // PyTorch Button
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        color: "#6eb109"
                        radius: 5
                        opacity: controlPanelRoot.isPyTorchSelected ? 1.0 : 0.5
                        border.color: controlPanelRoot.isPyTorchSelected ? "yellow" : "transparent"
                        border.width: controlPanelRoot.isPyTorchSelected ? 3 : 0
                        
                        Text {
                            text: "PyTorch"
                            font.pixelSize: 14
                            font.bold: true
                            color: controlPanelRoot.isPyTorchSelected ? "yellow" : "white"
                            anchors.centerIn: parent
                        }
                        
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                controlPanelRoot.isPyTorchSelected = true
                                controlPanelRoot.frameworkSelected("PyTorch")
                            }
                        }
                        
                        Behavior on opacity {
                            NumberAnimation { duration: 200 }
                        }
                    }
                    
                    // TensorFlow Button
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        color: "#6eb109"
                        radius: 5
                        opacity: !controlPanelRoot.isPyTorchSelected ? 1.0 : 0.5
                        border.color: !controlPanelRoot.isPyTorchSelected ? "yellow" : "transparent"
                        border.width: !controlPanelRoot.isPyTorchSelected ? 3 : 0
                        
                        Text {
                            text: "TensorFlow"
                            font.pixelSize: 14
                            font.bold: true
                            color: !controlPanelRoot.isPyTorchSelected ? "yellow" : "white"
                            anchors.centerIn: parent
                        }
                        
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                controlPanelRoot.isPyTorchSelected = false
                                controlPanelRoot.frameworkSelected("TensorFlow")
                            }
                        }
                        
                        Behavior on opacity {
                            NumberAnimation { duration: 200 }
                        }
                    }
                }
            }
        }
    }
}

