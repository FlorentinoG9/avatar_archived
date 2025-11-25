/*
    Drone Control View
    Three-column layout: Console Logger | Manual Drone Control | Camera View
*/

import QtQuick
import "../../layouts"
import "./components"
import "../../../../hardware/drone/camera"

Rectangle {
    id: droneControlView
    color: "#718399"
    
    property bool isConnected: (typeof backend !== "undefined" && backend) ? backend.is_connected_prop : false
    
    ThreeColumnLayout {
        leftRatio: 0.25
        centerRatio: 0.40
        spacing: 2
        
        leftContent: ConsoleLogger {
            id: consoleLogger
            anchors.fill: parent
        }
        
        centerContent: ControlPanel {
            id: controlPanel
            anchors.fill: parent
            isConnected: droneControlView.isConnected
            
            onDroneAction: function(action) {
                consoleLogger.appendLog("Drone action: " + action)
                if (typeof backend !== "undefined") {
                    backend.getDroneAction(action)
                }
            }
        }
        
        rightContent: CameraView {
            anchors.fill: parent
            cameraController: typeof cameraController !== "undefined" ? cameraController : null
        }
    }
    
    // Backend connections
    Connections {
        target: typeof backend !== "undefined" ? backend : null
        
        function onLogMessage(message) {
            consoleLogger.appendLog(message)
        }
    }
}

