//
//  TaskDateFormatter.swift
//  TodoistApp
//
//  Created by Sergio Rodríguez Pérez on 24/10/25.
//

import SwiftUI

import SwiftUI

struct TaskDateFormatter {
    static func formattedString(for date: Date) -> String {
        let calendar = Calendar.current
        let now = Date()
        
        if calendar.isDate(date, inSameDayAs: now) {
            return "Hoy"
        } else if let weekFromNow = calendar.date(byAdding: .day, value: 7, to: now),
                  date < weekFromNow {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE" // día de la semana
            return formatter.string(from: date)
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM" // día y mes
            return formatter.string(from: date)
        }
    }
    
    static func color(for date: Date) -> Color {
        let calendar = Calendar.current
        let now = Date()
        
        if calendar.isDate(date, inSameDayAs: now) {
            return .green
        } else if let weekFromNow = calendar.date(byAdding: .day, value: 7, to: now),
                  date < weekFromNow {
            return .brown
        } else {
            return .gray.opacity(0.8)
        }
    }
}
