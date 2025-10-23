//
//  TaskListView.swift
//  TodoistApp
//
//  Created by Sergio Rodríguez Pérez on 22/10/25.
//

import SwiftUI

struct TaskListView: View {
    var task : Task
    
    // Formateador de fecha legible, día de la actividad
    private var formattedDate: String {
        task.date.formatted(.dateTime.weekday(.wide))
    }

    // Color según prioridad
    private var priorityColor: Color {
        switch task.priority {
        case .high:
            return .red.opacity(0.7)
        case .medium:
            return .orange.opacity(0.7)
        case .low:
            return .blue.opacity(0.7)
        }
    }
    
    var body: some View {
        HStack (alignment: .top, spacing: 12) {
            // Circulo de Prioridad
            Circle()
                .fill(priorityColor)
                .overlay(Circle().stroke(style: StrokeStyle(lineWidth: 1)))
                .frame(width: 20, height: 20)
                .padding(.top, 2)
            
            VStack (alignment: .leading, spacing: 6){
                // Titulo de la tarea
                Text(task.title)
                    .font(Font.headline)
                    .foregroundColor(.primary)
                
                // Descripción de la tarea
                Text(task.details)
                    .font(Font.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                // Fecha de vencimiento
                HStack(spacing: 4) {
                    Image(systemName: "calendar")
                        .font(.caption)
                        .foregroundColor(.brown.opacity(1))
                    Text(formattedDate)
                        .font(.caption)
                        .foregroundColor(.brown.opacity(1))
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
        )
        .padding(.horizontal)

    }
}

#Preview {
    TaskListView(task: Task(id: UUID(), title: "MobileActivity08", details: "Tarea de Software", priority: .low, date: Date(), isCompleted: false))
}
