/*
    Brainwave Reading View
    Consolidates Brainwave modules into a complete viewport
    Uses TwoColumnLayout with 50/50 split
*/

import QtQuick
import QtQuick.Layouts
import "../../layouts"
import "./components"

Rectangle {
    id: brainwaveView
    color: "#718399"
    
    TwoColumnLayout {
        leftRatio: 0.67
        spacing: 10
        
        leftContent: ControlPanel {
            id: controlPanel
            anchors.fill: parent
            z: 1
            
            // Connect signals to backend
            onReadMyMind: {
                if (typeof backend !== "undefined") {
                    backend.readMyMind()
                }
            }
            
            onExecuteAction: {
                if (typeof backend !== "undefined") {
                    backend.executeAction()
                }
            }
            
            onNotWhatIWasThinking: function(action) {
                if (typeof backend !== "undefined") {
                    backend.notWhatIWasThinking(action)
                }
            }
            
            onConnectDrone: {
                if (typeof backend !== "undefined") {
                    backend.connectDrone()
                }
            }
            
            onKeepDroneAlive: {
                if (typeof backend !== "undefined") {
                    backend.keepDroneAlive()
                }
            }
            
            onModelSelected: function(modelName) {
                if (typeof backend !== "undefined") {
                    backend.selectModel(modelName)
                }
            }
            
            onFrameworkSelected: function(frameworkName) {
                if (typeof backend !== "undefined") {
                    backend.selectFramework(frameworkName)
                }
            }
            
            onDataModeChanged: function(mode) {
                if (typeof backend !== "undefined") {
                    backend.setDataMode(mode)
                }
            }
        }
        
        rightContent: Item {
            anchors.fill: parent
            z: 0
            
            ColumnLayout {
                anchors.fill: parent
                spacing: 0
                
                PredictionsTable {
                    id: predictionsTable
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredHeight: parent.height * 0.5
                }
                
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    color: "#4a5568"
                }
                
                ConsoleLog {
                    id: consoleLog
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredHeight: parent.height * 0.5
                }
            }
        }
    }
    
    // Backend connections
    Connections {
        target: typeof backend !== "undefined" ? backend : null
        
        function onLogMessage(message) {
            consoleLog.appendLog(message)
        }
        
        function onPredictionsTableUpdated(predictions) {
            predictionsTable.clearPredictions()
            for (var i = 0; i < predictions.length; i++) {
                predictionsTable.addPrediction(
                    predictions[i].count,
                    predictions[i].server,
                    predictions[i].label
                )
            }
        }
    }
}

