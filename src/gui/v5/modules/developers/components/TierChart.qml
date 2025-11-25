/*
    Tier Chart Component
    Dynamic bar chart using QtCharts for displaying contributor tiers
    Replaces static PNG images with interactive charts
*/

import QtQuick
import QtQuick.Controls
import QtCharts

Rectangle {
    id: chartContainer
    color: "transparent"
    
    // Properties
    property string tierName: "Gold"
    property var chartData: []
    property color barColor: "#D4AF37"
    
    // Color mapping for tiers
    readonly property var tierColors: ({
        "Gold": "#D4AF37",
        "Golden": "#D4AF37",
        "Silver": "#C0C0C0",
        "Bronze": "#CD7F32"
    })
    
    // Update bar color based on tier name
    Component.onCompleted: {
        barColor = tierColors[tierName] || "#D4AF37"
        updateChart()
    }
    
    // Watch for data changes
    onChartDataChanged: {
        updateChart()
    }
    
    ChartView {
        id: chartView
        anchors.fill: parent
        antialiasing: true
        backgroundColor: "transparent"
        legend.visible: false
        
        // Styling
        titleFont.pixelSize: 16
        titleFont.bold: true
        titleColor: "white"
        
        margins {
            top: 0
            bottom: 0
            left: 0
            right: 0
        }
        
        // Value axis (Y-axis)
        ValueAxis {
            id: valueAxis
            min: 0
            max: 100
            labelFormat: "%d"
            labelsColor: "white"
            labelsFont.pixelSize: 12
            gridVisible: true
            gridLineColor: "#3A4B68"
            color: "white"
            titleText: "Commits"
            titleFont.pixelSize: 14
            titleFont.bold: true
        }
        
        // Category axis (X-axis)
        BarCategoryAxis {
            id: categoryAxis
            labelsColor: "white"
            labelsFont.pixelSize: 10
            labelsAngle: -45
            gridVisible: false
            color: "white"
        }
        
        // Bar series
        BarSeries {
            id: barSeries
            axisX: categoryAxis
            axisY: valueAxis
            
            BarSet {
                id: barSet
                color: chartContainer.barColor
                borderColor: "white"
                borderWidth: 1
                labelColor: "white"
                labelFont.pixelSize: 12
                labelFont.bold: true
                
                // Handle hover events to show tooltip
                onHovered: function(status, index) {
                    if (status && chartData && index >= 0 && index < chartData.length) {
                        var contributor = chartData[index]
                        tooltip.text = contributor.name + "\n" + contributor.commits + " commits"
                        tooltip.visible = true
                    } else {
                        tooltip.visible = false
                    }
                }
            }
        }
    }
    
    // Tooltip for displaying contributor information
    ToolTip {
        id: tooltip
        x: chartView.width / 2 - width / 2
        y: 20
        visible: false
        timeout: -1  // Stay visible while hovering
        
        background: Rectangle {
            color: "#2A3B58"
            border.color: "white"
            border.width: 2
            radius: 6
            opacity: 0.95
        }
        
        contentItem: Text {
            text: tooltip.text
            color: "white"
            font.pixelSize: 14
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
        }
    }
    
    // Function to update chart with new data
    function updateChart() {
        if (!chartData || chartData.length === 0) {
            return
        }
        
        // Clear existing data
        barSet.remove(0, barSet.count)
        
        // Build categories array and values
        var categories = []
        var values = []
        var maxCommits = 0
        
        for (var i = 0; i < chartData.length; i++) {
            var contributor = chartData[i]
            categories.push(contributor.name)
            values.push(contributor.commits)
            
            if (contributor.commits > maxCommits) {
                maxCommits = contributor.commits
            }
        }
        
        // Set categories for X-axis
        categoryAxis.categories = categories
        
        // Set Y-axis range with some padding
        valueAxis.max = Math.ceil(maxCommits * 1.2)
        
        // Add values to bar set
        for (var j = 0; j < values.length; j++) {
            barSet.append(values[j])
        }
    }
    
    // Loading indicator
    BusyIndicator {
        anchors.centerIn: parent
        running: chartData.length === 0
        visible: running
    }
    
    // Empty state message
    Text {
        anchors.centerIn: parent
        text: "No data available"
        color: "white"
        font.pixelSize: 16
        visible: chartData.length === 0
    }
}

