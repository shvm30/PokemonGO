//
//  ChartView.swift
//  FinalPractice
//
//  Created by Владимир on 23.05.2023.
//

import Foundation
import SwiftUI
import Charts
var list: [Expenses] = []
var listOfIncomes: [Incomes] = []
struct ChartView: View {
    
   
    var body: some View {
        
        Chart(list) { model in
            LineMark(x: .value("Month", formatDate(model.date ?? Date())), y: .value("Expenes", model.value))
                .foregroundStyle(.red)
            PointMark(x: .value("Month",formatDate(model.date ?? Date())), y: .value("Expenses", model.value))
                .foregroundStyle(.blue)
            LineMark(x: .value("Month", formatDate(model.date ?? Date())), y: .value("Expenes", model.value))
                .foregroundStyle(.red)
            PointMark(x: .value("Month",formatDate(model.date ?? Date())), y: .value("Expenses", model.value))
                .foregroundStyle(.blue)
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
    }
    private func formatDate(_ date: Date) -> String {
        let cal = Calendar.current
        let dateComponents = cal.dateComponents ([.day, .month], from: date)
        guard let day = dateComponents.day, let month = dateComponents.month else { return "-" }
        return "\(day)/\(month)"
    }
}
    
