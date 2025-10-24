//
//  TaskCreateView.swift
//  TodoistApp
//
//  Created by Sergio Rodríguez Pérez on 23/10/25.
//

import SwiftUI
import SwiftData

struct TaskCreateView: View {
    // Formateador de fecha legible, día de la actividad
    private var formattedDate: String {
        newTask.date.formatted(.dateTime.weekday(.wide))
    }
    
    // Pop-ups
    @State private var showDatePicker = false
    @State private var showPriorityPicker = false
    
    // Para crear una nueva tarea
    @Environment(\.dismiss) private var dismiss
    var context : ModelContext
    
    @State private var newTask = Task(
        title: "",
        details: "",
        priority: .none,
        date: Date()
    )
    
    // Función para verificar que el titulo de la tarea no este vacío
    static func isValidName(_ name: String) -> Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        ZStack{
            // Fondo gradiente
            LinearGradient(
                colors: [.white, .red.opacity(0.3)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 12){
                // Input título
                TextField("Nombre de la tarea", text: $newTask.title)
                    .font(.title3)
                
                // Input descripción
                TextField("Descripción", text: $newTask.details)
                    .font(.subheadline)
                    .padding(.bottom, 5)
                
                HStack(spacing: 12) {
                    // Botón fecha
                    HStack {
                        Label(TaskDateFormatter.formattedString(for: newTask.date).capitalized, systemImage: "calendar")
                            .foregroundColor(TaskDateFormatter.color(for: newTask.date))
                        Spacer()
                    }
                    .padding()
                    .cornerRadius(10)
                    .contentShape(Rectangle())
                    .onTapGesture { showDatePicker = true }
                    
                    // Botón prioridad
                    HStack {
                        Label(newTask.priority.text, systemImage: "flag.fill")
                            .foregroundColor(newTask.priority.color)
                        Spacer()
                    }
                    .padding()
                    .cornerRadius(10)
                    .contentShape(Rectangle())
                    .onTapGesture { showPriorityPicker = true }
                }
                
                Divider()
                
                Button(action: {
                    // Acción para agregar tarea
                    context.insert(newTask)
                    dismiss()
                }) {
                    Text("Crear Tarea")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(newTask.title.isEmpty ? Color.red.opacity(0.3) : Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(!TaskCreateView.isValidName(newTask.title))
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(color: .gray.opacity(0.2), radius: 3)
            )
            // Popups
            .sheet(isPresented: $showDatePicker) {
                DatePickerPopup(task: newTask)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showPriorityPicker) {
                PriorityPickerPopup(priority: $newTask.priority)
                    .presentationDetents([.height(300)])
                    .presentationDragIndicator(.visible)
            }
            .padding(.horizontal)
        }
    }
}
