//
//  WeightChartView.swift
//  fitr
//
//  Created by Craig Sochocki on 2/8/24.
//

import SwiftUI
import Charts

struct WeightChartView: View {
    var entries: [WeightEntry]
    
    // Sort entries by date
    var sortedEntries: [WeightEntry] {
        entries.sorted { $0.date < $1.date }
    }
    
    var body: some View {
        Chart(sortedEntries) { entry in
            LineMark(
                x: .value("Date", entry.date),
                y: .value("Weight (lbs)", entry.weight))
            .interpolationMethod(.catmullRom)
            
            PointMark(
                x: .value("Date", entry.date),
                y: .value("Weight (lbs)", entry.weight)).symbolSize(10)
        }
        
        .chartXAxis {
            AxisMarks(position: .bottom, values: .automatic) {
                AxisGridLine()
                AxisValueLabel(format: .dateTime.month().day(), centered: true)
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading) {
                AxisValueLabel()
                AxisTick()
                AxisGridLine()
            }
        }
    }
}

let viewModel = WeightTrackingViewModel()
let entries = viewModel.weightEntries

#Preview {
    WeightChartView(entries: entries)
}
