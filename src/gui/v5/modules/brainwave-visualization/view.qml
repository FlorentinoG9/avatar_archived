/*
    Brainwave Visualization View
    Displays 6 brainwave graphs in a grid with dataset controls
    Uses SingleColumnLayout with GraphGrid and DatasetSelector
*/

import QtQuick
import QtQuick.Layouts
import "../../layouts"
import "./components"

Rectangle {
    id: visualizationView
    color: "#718399"
    
    SingleColumnLayout {
        spacing: 10
        
        content: ColumnLayout {
            anchors.fill: parent
            spacing: 10
            
            // Graph Grid - fills most of the space
            GraphGrid {
                id: graphGrid
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.margins: 10
                
                imageModel: ListModel {
                    id: imageModel
                }
            }
            
            // Dataset Selector - fixed at bottom
            DatasetSelector {
                id: datasetSelector
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                
                onRefreshClicked: {
                    if (typeof backend !== "undefined") {
                        backend.setDataset("refresh")
                    }
                }
                
                onRollbackClicked: {
                    if (typeof backend !== "undefined") {
                        backend.setDataset("rollback")
                    }
                }
            }
        }
    }
    
    // Backend connections for updating graph images
    Connections {
        target: typeof backend !== "undefined" ? backend : null
        
        function onImagesReady(imageData) {
            imageModel.clear()
            for (var i = 0; i < imageData.length; i++) {
                imageModel.append({
                    "graphTitle": imageData[i].graphTitle,
                    "imagePath": imageData[i].imagePath
                })
            }
        }
    }
    
    // Initialize with default dataset on load
    Component.onCompleted: {
        if (typeof backend !== "undefined") {
            backend.setDataset("refresh")
        }
    }
}


