import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: cameraViewRoot
    width: 400
    height: 300
    color: "#2a3f5f"

    property var cameraController: null

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 10

        // Header
        Text {
            text: "Camera View"
            color: "#c0c0c0"
            font.bold: true
            font.pixelSize: 18
            Layout.alignment: Qt.AlignHCenter
        }

        // Video Display Area
        Rectangle {
            id: videoContainer
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#1a2332"
            border.color: "#c0c0c0"
            border.width: 1
            radius: 6

            Image {
                id: videoFrame
                anchors.fill: parent
                anchors.margins: 5
                fillMode: Image.PreserveAspectFit
                source: ""
                
                // Placeholder when no video
                Column {
                    anchors.centerIn: parent
                    spacing: 15
                    visible: videoFrame.source == ""

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "📹"
                        font.pixelSize: 48
                        color: "white"
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Camera Ready"
                        font.pixelSize: 16
                        color: "white"
                        font.bold: true
                    }
                }
            }

            // Help icon
            Text {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.margins: 10
                text: "?"
                font.pixelSize: 20
                font.bold: true
                color: "white"
            }
        }

        // Control Buttons
        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 45
            spacing: 10

            Button {
                id: startBtn
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                text: "Start Stream"
                
                property bool isHovered: false
                
                HoverHandler {
                    onHoveredChanged: startBtn.isHovered = hovered
                }

                background: Rectangle {
                    color: startBtn.isHovered ? "#2a3f5f" : "#1a2332"
                    radius: 6
                    border.width: startBtn.isHovered ? 2 : 1
                    border.color: "#c0c0c0"
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }

                contentItem: Text {
                    text: startBtn.text
                    font.pixelSize: 12
                    font.bold: true
                    color: "#c0c0c0"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    console.log("✅ Start Stream button clicked!")
                    if (cameraController) {
                        cameraController.start_camera_stream()
                    }
                }
            }

            Button {
                id: stopBtn
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                text: "Stop Stream"
                
                property bool isHovered: false
                
                HoverHandler {
                    onHoveredChanged: stopBtn.isHovered = hovered
                }

                background: Rectangle {
                    color: stopBtn.isHovered ? "#2a3f5f" : "#1a2332"
                    radius: 6
                    border.width: stopBtn.isHovered ? 2 : 1
                    border.color: "#c0c0c0"
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }

                contentItem: Text {
                    text: stopBtn.text
                    font.pixelSize: 12
                    font.bold: true
                    color: "#c0c0c0"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    console.log("✅ Stop Stream button clicked!")
                    if (cameraController) {
                        cameraController.stop_camera_stream()
                    }
                }
            }

            Button {
                id: captureBtn
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                text: "Capture"
                
                property bool isHovered: false
                
                HoverHandler {
                    onHoveredChanged: captureBtn.isHovered = hovered
                }

                background: Rectangle {
                    color: captureBtn.isHovered ? "#2a3f5f" : "#1a2332"
                    radius: 6
                    border.width: captureBtn.isHovered ? 2 : 1
                    border.color: "#c0c0c0"
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }

                contentItem: Text {
                    text: captureBtn.text
                    font.pixelSize: 12
                    font.bold: true
                    color: "#c0c0c0"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    console.log("✅ Capture button clicked!")
                    if (cameraController) {
                        cameraController.capture_photo()
                    }
                }
            }
        }
    }
}