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
    
    // Sort entries by timestamp
    var sortedEntries: [WeightEntry] {
        entries.sorted { $0.timestamp < $1.timestamp }
    }
    
    var body: some View {
        Chart(sortedEntries) { entry in
            LineMark(
                x: .value("Date", entry.timestamp),
                y: .value("Weight (lbs)", entry.weight))
            .interpolationMethod(.catmullRom)
            
            PointMark(
                x: .value("Date", entry.timestamp),
                y: .value("Weight (lbs)", entry.weight)).symbolSize(10).foregroundStyle(.blue)
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
        .chartOverlay {
            proxy in
            GeometryReader { geo in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged {
                                value in
                                let location = value.location
                                
                                if let date: Date = proxy.value(atX: location.x),
                                   let weight: Double = proxy.value(atY: location.y) {
                                    print("Date: \(date), Weight:  \(weight)")
                                }
                            })}
        }
    }
}

let viewModel = WeightEntriesViewModel()
let entries = viewModel.entries

#Preview {
    WeightChartView(entries: entries)
}
