/*
    Developers View
    Displays developer contribution tiers and logs
    Uses TwoRowLayout with custom structure
*/

import QtQuick
import QtQuick.Layouts
import "../../layouts"
import "./components"

Rectangle {
    id: developersView
    color: "#718399"
    
    // Add margins to prevent bleeding and ensure proper fit
    anchors.margins: 10
    
    // Ensure content doesn't overflow
    clip: true
    
    TwoRowLayout {
        topRatio: 0.5
        spacing: 20
        anchors.fill: parent
        anchors.margins: 15
        
        topContent: RowLayout {
            anchors.fill: parent
            spacing: 15
            
            TierPanel {
                id: goldPanel
                Layout.fillWidth: true
                Layout.fillHeight: true
                tierName: "Gold"
            }
            
            TierPanel {
                id: silverPanel
                Layout.fillWidth: true
                Layout.fillHeight: true
                tierName: "Silver"
            }
            
            TierPanel {
                id: bronzePanel
                Layout.fillWidth: true
                Layout.fillHeight: true
                tierName: "Bronze"
            }
        }
        
        bottomContent: RowLayout {
            anchors.fill: parent
            spacing: 10
            
            DevLog {
                id: devLog
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            
            MedalDisplay {
                id: medalDisplay
                Layout.preferredWidth: 230
                Layout.fillHeight: true
                
                onRefreshClicked: {
                    if (typeof backend !== "undefined") {
                        // Refresh text data
                        devLog.devText = backend.getDevList()
                        ticketLog.ticketText = backend.getTicketsByDev()
                        
                        // Refresh chart data for all tiers
                        goldPanel.refreshChartData()
                        silverPanel.refreshChartData()
                        bronzePanel.refreshChartData()
                    }
                }
            }
            
            TicketLog {
                id: ticketLog
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
    
    // Initialize on load
    Component.onCompleted: {
        if (typeof backend !== "undefined") {
            devLog.devText = backend.getDevList()
            ticketLog.ticketText = backend.getTicketsByDev()
        }
    }
}

