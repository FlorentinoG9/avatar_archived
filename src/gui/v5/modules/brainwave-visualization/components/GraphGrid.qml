/*
    Brainwave Graph Grid Module
    Displays 6 graph images in a 3x2 grid
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: graphGrid
    
    // Model for graph images
    property var imageModel: ListModel {}
    
    GridLayout {
        anchors.fill: parent
        columns: 3
        columnSpacing: 10
        rowSpacing: 10
        
        Repeater {
            model: graphGrid.imageModel
            
            delegate: Rectangle {
                color: "#e6e6f0"
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width / 3 - 10
                Layout.preferredHeight: (parent.height - 10) / 2
                border.color: "#d0d0d8"
                border.width: 1
                radius: 4
                
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 0
                    
                    // Title Bar
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 30
                        color: "#242c4d"
                        
                        Text {
                            // Extract just the first word from the title
                            text: {
                                var parts = model.graphTitle ? model.graphTitle.split(" ") : ["Graph"]
                                return parts[0]
                            }
                            color: "white"
                            font.bold: true
                            font.pixelSize: 14
                            anchors.centerIn: parent
                        }
                    }
                    
                    // Graph Image Container
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "white"
                        
                        Image {
                            anchors.fill: parent
                            anchors.margins: 8
                            source: model.imagePath || ""
                            fillMode: Image.PreserveAspectFit
                            smooth: true
                            antialiasing: true
                            
                            // Loading indicator
                            BusyIndicator {
                                anchors.centerIn: parent
                                running: parent.status === Image.Loading
                                visible: running
                            }
                            
                            // Error handling
                            Text {
                                anchors.centerIn: parent
                                text: "Image not available"
                                color: "#999"
                                font.pixelSize: 12
                                visible: parent.status === Image.Error
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Function to update images
    function updateImages(imageData) {
        imageModel.clear()
        for (var i = 0; i < imageData.length; i++) {
            imageModel.append(imageData[i])
        }
    }
}

