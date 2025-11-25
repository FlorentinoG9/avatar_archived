/*
    NAO Control View
    Consolidates NAO modules into a complete viewport
    Uses TwoColumnLayout for structure
*/

import QtQuick
import "../../layouts"
import "./components"

Rectangle {
    id: naoControlView
    color: "#718399"
    
    TwoColumnLayout {
        leftWidth: 500
        
        leftContent: LeftPanel {
            id: leftPanel
            anchors.fill: parent
            
            // Connect signals to 3D view functions
            onMoveForward: view3D.moveForward()
            onMoveBackward: view3D.moveBackward()
            onTurnLeft: view3D.turnLeft()
            onTurnRight: view3D.turnRight()
            onMoveUp: view3D.moveUp()
            onMoveDown: view3D.moveDown()
        }
        
        rightContent: Item {
            anchors.fill: parent
            
            View3D {
                id: view3D
                anchors.fill: parent
            }
            
            // Connection Card overlay
            ConnectionCard {
                id: connectionCard
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 10
                
                onConnectClicked: function(ip, port) {
                    leftPanel.appendLog("Connecting to NAO at " + ip + ":" + port)
                }
            }
        }
    }
    
    // Backend connections
    Connections {
        target: typeof backend !== "undefined" ? backend : null
        
        function onImagesReady(imageData) {
            // Handle if needed
        }
    }
}

