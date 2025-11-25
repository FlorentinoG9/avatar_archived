/*
    Developers Tier Panel Module
    Reusable panel for displaying Gold/Silver/Bronze contributor tiers with interactive charts
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: tierPanel
    color: "#1A2B48"
    radius: 10
    border.color: "white"
    
    // Properties
    property string tierName: "Gold"
    property var chartData: []
    
    // Ensure minimum size to prevent components from becoming too small
    Layout.minimumWidth: 150
    Layout.minimumHeight: 200
    
    // Function to refresh chart data
    function refreshChartData() {
        if (typeof backend !== "undefined") {
            chartData = backend.getChartData(tierName)
        }
    }
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 8
        
        Text {
            text: tierPanel.tierName
            color: "white"
            font.bold: true
            font.pixelSize: 26
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }
        
        Rectangle {
            color: "#2A3B58"
            radius: 8
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            TierChart {
                anchors.fill: parent
                anchors.margins: 10
                tierName: tierPanel.tierName
                chartData: tierPanel.chartData
            }
        }
    }
    
    // Load data on component creation
    Component.onCompleted: {
        refreshChartData()
    }
}

