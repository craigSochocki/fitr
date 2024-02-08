//
//  WeightChartView.swift
//  fitr
//
//  Created by Craig Sochocki on 2/8/24.
//

import SwiftUI

struct WeightChartView: View {
    var entries: [WeightEntry]
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date)
    }
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for (index, entry) in entries.enumerated() {
                    let xPosition = geometry.size.width / CGFloat(entries.count - 1) * CGFloat(index)
                    
                    let weightNormalized = CGFloat((entry.weight - 100) / 400)
                    
                    let yPosition = geometry.size.height * (1 - weightNormalized)
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    } else {
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }
            }
            .stroke(Color.blue, lineWidth: 2)
            
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
