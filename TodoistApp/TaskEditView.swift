//
//  TaskEditView.swift
//  TodoistApp
//
//  Created by Sergio Rodríguez Pérez on 22/10/25.
//

import SwiftUI

struct TaskEditView: View {
    
    @Bindable var task : Task
    
    // Formateador de fecha legible, día de la actividad
    private var formattedDate: String {
        task.date.formatted(.dateTime.weekday(.wide))
    }
    
    // Pop-ups
    @State private var showEditPopup = false
    @State private var showDatePicker = false
    @State private var showPriorityPicker = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            // Encabezado
            HStack{
                Circle()
                    .fill(task.priority.color)
                    .overlay(Circle().stroke(style: StrokeStyle(lineWidth: 1)))
                    .frame(width: 20, height: 20)
                Text(task.title)
                    .font(.headline)
                    .onTapGesture{
                        showEditPopup = true
                    }
                Spacer()
            }
            
            // Descripción
            Label(task.details, systemImage: "text.alignleft")
                .font(.subheadline)
                .onTapGesture{
                    showEditPopup = true
                }
            
            Divider()
            
            // Fecha
            HStack{
                Label(formattedDate, systemImage: "calendar")
                    .font(.subheadline)
                    .onTapGesture{
                        showDatePicker = true
                    }
                Spacer()
            }
            
            Divider()
            
            // Prioridad
            HStack{
                Label(task.priority.text, systemImage: "flag.fill")
                    .font(.subheadline)
                    .onTapGesture{
                        showPriorityPicker = true
                    }
                Spacer()
            }
        }
        .padding()
        .padding(.horizontal, 5)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .gray.opacity(0.2), radius: 3)
        )
        // Popups
        .sheet(isPresented: $showEditPopup) {
            EditTaskPopup(task: task)
        }
        .sheet(isPresented: $showDatePicker) {
            DatePickerPopup(task: task)
        }
        .sheet(isPresented: $showPriorityPicker) {
            PriorityPickerPopup(task: task)
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    TaskEditView(task: Task(id: UUID(), title: "MobileActivity08", details: "Tarea de Software", priority: .low, date: Date(), isCompleted: false))
}
