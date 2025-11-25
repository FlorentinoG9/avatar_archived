/*
    Transfer Data View
    Main view for data transfer operations via SFTP
    Uses SingleColumnLayout with components
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../layouts"
import "./components"

Rectangle {
    id: transferDataView
    color: "#718399"
    
    Item {
        anchors.fill: parent
        
        ColumnLayout {
            anchors.centerIn: parent
            width: Math.min(parent.width * 0.9, 700)
            spacing: 20
            
            // Title
            Text {
                text: "SFTP Data Transfer"
                color: "white"
                font.bold: true
                font.pixelSize: 28
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 10
            }
            
            // Connection Form
            ConnectionForm {
                id: connectionForm
                Layout.fillWidth: true
            }
            
            // Directory Selector
            DirectorySelector {
                id: directorySelector
                Layout.fillWidth: true
            }
            
            // Control Buttons
            ControlButtons {
                id: controlButtons
                Layout.fillWidth: true
                Layout.topMargin: 10
                
                onSaveConfigClicked: {
                    console.log("Save Config clicked")
                    saveConfiguration()
                }
                
                onLoadConfigClicked: {
                    console.log("Load Config clicked")
                    loadConfiguration()
                }
                
                onClearConfigClicked: {
                    console.log("Clear Config clicked")
                    clearConfiguration()
                }
                
                onUploadClicked: {
                    console.log("Upload clicked")
                    uploadData()
                }
            }
            
            // Status Message
            Text {
                id: statusMessage
                text: ""
                color: "lightgreen"
                font.bold: true
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 10
                visible: text !== ""
            }
            
        }
    }
    
    // Configuration functions
    function saveConfiguration() {
        // Save current configuration
        var config = {
            ip: connectionForm.targetIP,
            username: connectionForm.targetUsername,
            password: connectionForm.targetPassword,
            privateKey: connectionForm.privateKeyDir,
            ignoreHostKey: connectionForm.ignoreHostKey,
            sourceDir: directorySelector.sourceDirectory,
            targetDir: directorySelector.targetDirectory
        }
        
        // Save to local storage or backend
        console.log("Saving configuration:", JSON.stringify(config))
        showStatus("Configuration saved successfully!", "lightgreen")
        
        // TODO: Implement actual save logic with backend
    }
    
    function loadConfiguration() {
        // Load saved configuration
        console.log("Loading configuration...")
        showStatus("Configuration loaded!", "lightblue")
        
        // TODO: Implement actual load logic with backend
        // For now, just show a placeholder
    }
    
    function clearConfiguration() {
        // Clear all fields
        connectionForm.targetIP = ""
        connectionForm.targetUsername = ""
        connectionForm.targetPassword = ""
        connectionForm.privateKeyDir = ""
        connectionForm.ignoreHostKey = true
        directorySelector.sourceDirectory = ""
        directorySelector.targetDirectory = "/home/"
        
        showStatus("Configuration cleared!", "yellow")
    }
    
    function uploadData() {
        // Validate fields
        if (!connectionForm.targetIP || !connectionForm.targetUsername) {
            showStatus("Please fill in IP and Username!", "red")
            return
        }
        
        if (!directorySelector.sourceDirectory) {
            showStatus("Please select source directory!", "red")
            return
        }
        
        // Perform upload
        console.log("Starting upload...")
        console.log("From:", directorySelector.sourceDirectory)
        console.log("To:", connectionForm.targetIP + ":" + directorySelector.targetDirectory)
        
        showStatus("Upload started...", "lightblue")
        
        // Call backend SFTP upload
        if (typeof backend !== "undefined") {
            var result = backend.uploadViaSFTP(
                connectionForm.targetIP,
                connectionForm.targetUsername,
                connectionForm.privateKeyDir,
                connectionForm.targetPassword,
                connectionForm.ignoreHostKey,
                directorySelector.sourceDirectory,
                directorySelector.targetDirectory
            )
            
            // Show result
            if (result.startsWith("Success:")) {
                showStatus("Upload completed successfully!", "lightgreen")
            } else {
                showStatus(result, "red")
            }
        } else {
            showStatus("Backend not available!", "red")
        }
    }
    
    function showStatus(message, color) {
        statusMessage.text = message
        statusMessage.color = color
        
        // Auto-hide after 3 seconds
        statusTimer.restart()
    }
    
    // Timer to auto-hide status
    Timer {
        id: statusTimer
        interval: 3000
        onTriggered: {
            statusMessage.text = ""
        }
    }
}

