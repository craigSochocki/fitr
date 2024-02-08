//
//  WeightChartView.swift
//  fitr
//
//  Created by Craig Sochocki on 2/8/24.
//

import SwiftUI

struct WeightChartView: View {
    var entries: [WeightEntry]
    
    private var maxWeight: Double {
        entries.max(by: { $0.weight < $1.weight })?.weight ?? 0
    }
    
    private var adjustedMaxWeight: Double {
        let margin = (maxWeight - minWeight) * 0.1
        return maxWeight + margin
    }
    
    private var minWeight: Double {
        entries.min(by: { $0.weight < $1.weight })?.weight ?? 0
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date)
    }
    
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let weightRange = maxWeight - minWeight
            
            let scale = height / (weightRange > 0 ? weightRange : 1)
            
            let topY = (maxWeight - maxWeight) * scale // This will be 0 (top of chart)
            let bottomY = (maxWeight - minWeight) * scale // Map minWeight to the bottom
            Path { path in
                for (index, entry) in entries.enumerated() {
                    let xPosition = geometry.size.width / CGFloat(entries.count - 1) * CGFloat(index)
                    
                    let weightNormalized = CGFloat((entry.weight - minWeight) / (adjustedMaxWeight - minWeight))
                    
                    let yPosition = (1 - weightNormalized) * (geometry.size.height - 20)
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    } else {
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }
            }
            .stroke(Color.blue, lineWidth: 2)
            
            Path { path in
                
                [topY, bottomY].forEach { yPosition in
                    path.move(to: CGPoint(x: 0, y: yPosition))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: yPosition))
                }}
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            
            // y-axis labels at the edges
            VStack {
                Text("\(entries.max(by: { $0.weight < $1.weight })?.weight ?? 0, specifier: "%.0f") lbs")
                Spacer()
                Text("\(entries.min(by: { $0.weight < $1.weight })?.weight ?? 0, specifier: "%.0f") lbs")
            }
            .padding(.leading)
            
            // x-axis labels (start and end dates)
            HStack {
                Text(formatDate(entries.first?.timestamp ?? Date()))
                Spacer()
                Text(formatDate(entries.last?.timestamp ?? Date()))
            }
            .padding(.top, geometry.size.height)
        }
    }
}
