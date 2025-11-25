/*
    File Shuffler View
    Main view for file shuffling operations
    Uses SingleColumnLayout with components
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import Qt.labs.platform
import "../../layouts"
import "./components"

Rectangle {
    id: fileShufflerView
    color: "#718399"
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20
        
        // Title
        Text {
            text: "File Shuffler"
            color: "white"
            font.bold: true
            font.pixelSize: 28
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }
        
        // Output Display
        OutputDisplay {
            id: outputDisplay
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.7
            Layout.preferredHeight: parent.height * 0.5
            Layout.alignment: Qt.AlignHCenter
        }
        
        // Action Buttons
        ActionButtons {
            id: actionButtons
            Layout.alignment: Qt.AlignHCenter
            
            onUnifyThoughtsClicked: {
                unifyThoughtsDialog.open()
                outputDisplay.setOutput("Running Thoughts Unifier...\n")
                statusIndicators.reset()
            }
            
            onRemove8ChannelClicked: {
                remove8channelDialog.open()
                outputDisplay.setOutput("Running 8 Channel Data Remover...\n")
                statusIndicators.reset()
            }
            
            onRunShufflerClicked: {
                fileShufflerDialog.open()
                outputDisplay.setOutput("Running File Shuffler...\n")
                statusIndicators.reset()
            }
        }
        
        // Status Indicators
        StatusIndicators {
            id: statusIndicators
            Layout.alignment: Qt.AlignHCenter
        }
        
        // Spacer
        Item {
            Layout.fillHeight: true
        }
    }
    
    // File Shuffler Dialog
    FolderDialog {
        id: fileShufflerDialog
        folder: "file:///"
        visible: false
        
        onAccepted: {
            console.log("Selected folder:", fileShufflerDialog.folder)
            
            if (typeof fileShufflerGui !== "undefined") {
                var output = fileShufflerGui.run_file_shuffler_program(fileShufflerDialog.folder)
                outputDisplay.appendOutput(output)
                statusIndicators.setShuffleComplete(true)
            } else {
                outputDisplay.appendOutput("\nError: Backend not available")
            }
        }
        
        onRejected: {
            console.log("Folder dialog canceled")
            outputDisplay.appendOutput("\nOperation canceled")
        }
    }
    
    // Unify Thoughts Dialog
    FolderDialog {
        id: unifyThoughtsDialog
        folder: "file:///"
        
        onAccepted: {
            console.log("Selected folder:", unifyThoughtsDialog.folder)
            
            if (typeof fileShufflerGui !== "undefined") {
                var output = fileShufflerGui.unify_thoughts(unifyThoughtsDialog.folder)
                outputDisplay.appendOutput(output)
                outputDisplay.appendOutput("\nThoughts Unified!\n")
                statusIndicators.setThoughtsUnified(true)
            } else {
                outputDisplay.appendOutput("\nError: Backend not available")
            }
        }
        
        onRejected: {
            console.log("Folder dialog canceled")
            outputDisplay.appendOutput("\nOperation canceled")
        }
    }
    
    // Remove 8 Channel Dialog
    FolderDialog {
        id: remove8channelDialog
        folder: "file:///"
        
        onAccepted: {
            console.log("Selected folder:", remove8channelDialog.folder)
            
            if (typeof fileShufflerGui !== "undefined") {
                var output = fileShufflerGui.remove_8_channel(remove8channelDialog.folder)
                outputDisplay.appendOutput(output)
                outputDisplay.appendOutput("\n8 Channel Data Files Removed!\n")
                statusIndicators.setChannelRemoved(true)
            } else {
                outputDisplay.appendOutput("\nError: Backend not available")
            }
        }
        
        onRejected: {
            console.log("Folder dialog canceled")
            outputDisplay.appendOutput("\nOperation canceled")
        }
    }
}

