/*
    NAO 3D View Module
    Contains the 3D NAO model viewer with lighting and camera
*/

import QtQuick
import QtQuick3D
import "../../../../assets/models/nao"

Rectangle {
    id: view3DContainer
    color: "#2f2f2f"
    radius: 6
    
    // Expose the NAO model for external control
    property alias naoModel: naoModel
    
    // Animation properties
    property bool animationInProgress: false
    property int modelRotationY: 0
    property real moveDistance: 50
    property real verticalStep: 50
    property int verticalState: 0
    property int maxVerticalState: 3
    property int rotationStep: 90
    
    View3D {
        anchors.fill: parent
        
        environment: SceneEnvironment {
            clearColor: "#2e2e2e"
            backgroundMode: SceneEnvironment.Color
        }
        
        PerspectiveCamera {
            id: camera
            position: Qt.vector3d(0, 250, 800)
            eulerRotation.x: -10
            clipFar: 5000
        }
        
        DirectionalLight {
            eulerRotation.x: -45
            eulerRotation.y: 45
            brightness: 1.5
            castsShadow: true
        }
        
        DirectionalLight {
            eulerRotation.x: 30
            eulerRotation.y: -60
            brightness: 1.2
        }
        
        PointLight {
            position: Qt.vector3d(0, 400, 400)
            brightness: 800
        }
        
        // Load NAO model
        Nao {
            id: naoModel
            scale: Qt.vector3d(100, 100, 100)
            position: Qt.vector3d(0, -100, 0)
        }
    }
    
    // Animations
    PropertyAnimation {
        id: moveAnim
        target: naoModel
        property: "position"
        duration: 1000
        onStopped: view3DContainer.animationInProgress = false
    }
    
    PropertyAnimation {
        id: rotateAnim
        target: naoModel
        property: "eulerRotation"
        duration: 800
        onStopped: view3DContainer.animationInProgress = false
    }
    
    // Jump (Takeoff) Animation - NAO jumps up with realistic motion
    SequentialAnimation {
        id: jumpAnim
        
        property real startY: 0
        property real startRotX: 0
        
        ScriptAction {
            script: {
                jumpAnim.startY = naoModel.position.y
                jumpAnim.startRotX = naoModel.eulerRotation.x
            }
        }
        
        // Crouch down slightly before jumping
        ParallelAnimation {
            NumberAnimation {
                target: naoModel
                property: "position.y"
                duration: 200
                easing.type: Easing.InQuad
                to: jumpAnim.startY - 20
            }
            NumberAnimation {
                target: naoModel.scale
                property: "y"
                duration: 200
                easing.type: Easing.InQuad
                to: 95
            }
        }
        
        // Jump up
        ParallelAnimation {
            NumberAnimation {
                target: naoModel
                property: "position.y"
                duration: 600
                easing.type: Easing.OutQuad
                to: jumpAnim.startY + 120
            }
            NumberAnimation {
                target: naoModel.scale
                property: "y"
                duration: 300
                easing.type: Easing.OutQuad
                to: 100
            }
            NumberAnimation {
                target: naoModel
                property: "eulerRotation.x"
                duration: 300
                easing.type: Easing.OutQuad
                to: jumpAnim.startRotX - 5
            }
        }
        
        // Slight rotation back to normal
        NumberAnimation {
            target: naoModel
            property: "eulerRotation.x"
            duration: 300
            easing.type: Easing.InOutQuad
            to: jumpAnim.startRotX
        }
        
        onStopped: {
            view3DContainer.animationInProgress = false
            view3DContainer.verticalState++
        }
    }
    
    // Land Animation - NAO lands with impact and stabilization
    SequentialAnimation {
        id: landAnim
        
        property real startY: 0
        
        ScriptAction {
            script: {
                landAnim.startY = naoModel.position.y
            }
        }
        
        // Fall down
        NumberAnimation {
            target: naoModel
            property: "position.y"
            duration: 500
            easing.type: Easing.InQuad
            to: landAnim.startY - 120
        }
        
        // Impact - slight bounce and squash
        ParallelAnimation {
            SequentialAnimation {
                NumberAnimation {
                    target: naoModel.scale
                    property: "y"
                    duration: 100
                    easing.type: Easing.OutQuad
                    to: 92
                }
                NumberAnimation {
                    target: naoModel.scale
                    property: "y"
                    duration: 200
                    easing.type: Easing.OutBounce
                    to: 100
                }
            }
            SequentialAnimation {
                NumberAnimation {
                    target: naoModel
                    property: "position.y"
                    duration: 100
                    easing.type: Easing.OutQuad
                    to: landAnim.startY - 105
                }
                NumberAnimation {
                    target: naoModel
                    property: "position.y"
                    duration: 200
                    easing.type: Easing.OutBounce
                    to: landAnim.startY - 120
                }
            }
        }
        
        onStopped: {
            view3DContainer.animationInProgress = false
            view3DContainer.verticalState--
        }
    }
    
    // Movement functions
    function moveForward() {
        if (animationInProgress) return
        
        var angleRad = modelRotationY * Math.PI / 180.0
        var start = naoModel.position
        var end = Qt.vector3d(
            start.x + moveDistance * Math.sin(angleRad),
            start.y,
            start.z + moveDistance * Math.cos(angleRad)
        )
        animationInProgress = true
        moveAnim.from = start
        moveAnim.to = end
        moveAnim.start()
    }
    
    function moveBackward() {
        if (animationInProgress) return
        
        var angleRad = modelRotationY * Math.PI / 180.0
        var start = naoModel.position
        var end = Qt.vector3d(
            start.x - moveDistance * Math.sin(angleRad),
            start.y,
            start.z - moveDistance * Math.cos(angleRad)
        )
        animationInProgress = true
        moveAnim.from = start
        moveAnim.to = end
        moveAnim.start()
    }
    
    function turnLeft() {
        if (animationInProgress) return
        
        modelRotationY = (modelRotationY - rotationStep + 360) % 360
        var start = naoModel.eulerRotation
        var end = Qt.vector3d(start.x, start.y - rotationStep, start.z)
        animationInProgress = true
        rotateAnim.from = start
        rotateAnim.to = end
        rotateAnim.start()
    }
    
    function turnRight() {
        if (animationInProgress) return
        
        modelRotationY = (modelRotationY + rotationStep) % 360
        var start = naoModel.eulerRotation
        var end = Qt.vector3d(start.x, start.y + rotationStep, start.z)
        animationInProgress = true
        rotateAnim.from = start
        rotateAnim.to = end
        rotateAnim.start()
    }
    
    // Jump/Takeoff - NAO performs a realistic jump
    function moveUp() {
        if (animationInProgress || verticalState >= maxVerticalState) return
        
        animationInProgress = true
        jumpAnim.start()
    }
    
    // Land - NAO lands with realistic impact
    function moveDown() {
        if (animationInProgress || verticalState <= 0) return
        
        animationInProgress = true
        landAnim.start()
    }
}

