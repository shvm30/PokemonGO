//
//  ChartView.swift
//  FinalPractice
//
//  Created by Владимир on 23.05.2023.
//

import Foundation
import SwiftUI
import Charts


struct ChartViewIE: View {
    var body: some View {
        Text("Доходы")
        if listOfIncomes.isEmpty {
            Text("Нет данных")
                .foregroundColor(.gray)
                .padding(30)
        }
            
            Chart(listOfIncomes) { model in
                
                
                LineMark(x: .value("Date", formatDate(model.date ?? Date())), y: .value("Incomes", model.value))
                    .foregroundStyle(.green)
                PointMark(x: .value("Date", formatDate(model.date ?? Date())), y: .value("Incomes", model.value))
                    .foregroundStyle(.blue)
            }.padding(20)
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
            Text("Расходы")
        if list.isEmpty {
            Text("Нет данных")
                .foregroundColor(.gray)
                .padding(30)
        }
            Chart(list) { model in
                
                LineMark(x: .value("Date", formatDate(model.date ?? Date())), y: .value("Expenses", model.value))
                    .foregroundStyle(.red)
                PointMark(x: .value("Date", formatDate(model.date ?? Date())), y: .value("Expenses", model.value))
                    .foregroundStyle(.blue)
                
            }.padding(10)
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
