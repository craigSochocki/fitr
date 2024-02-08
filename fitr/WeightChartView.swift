//
//  WeightChartView.swift
//  fitr
//
//  Created by Craig Sochocki on 2/8/24.
//

import SwiftUI

struct WeightChartView: View {
    var entries: [WeightEntry]
    
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
            }.stroke(Color.blue, lineWidth: 2)
        }
    }
}

#Preview {
    WeightChartView(entries: [
        WeightEntry(weight: 200.0, timestamp: Date()),
        WeightEntry(weight: 215.0, timestamp: Date(timeInterval: 86400, since: Date()))
    ])
}
