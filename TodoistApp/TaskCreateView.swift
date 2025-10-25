//
//  TaskCreateView.swift
//  TodoistApp
//
//  Created by Sergio Rodríguez Pérez on 23/10/25.
//

import SwiftUI
import SwiftData

struct TaskCreateView: View {
    // Pop-ups
    @State private var showDatePicker = false
    @State private var showPriorityPicker = false
    
    @Environment(\.dismiss) private var dismiss
    var context : ModelContext
    
    // Variable para crear una nueva tarea
    @State private var newTask = Task(
        title: "",
        details: "",
        priority: .none,
        date: Date()
    )
    
    // Función para verificar que el titulo de la tarea no este vacío o sea solo espacios
    static func isValidName(_ name: String) -> Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        ZStack{
            // Fondo
            LinearGradient(
                colors: [.white, .red.opacity(0.3)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 12){
                // Input titulo
                TextField("Nombre de la tarea", text: $newTask.title)
                    .font(.title3)
                
                // Input descripción
                TextField("Descripción", text: $newTask.details)
                    .font(.subheadline)
                    .padding(.bottom, 5)
                
                HStack(spacing: 12) {
                    // Botón para selector de fecha
                    HStack {
                        Label(TaskDateFormatter.formattedString(for: newTask.date).capitalized, systemImage: "calendar")
                            .foregroundColor(TaskDateFormatter.color(for: newTask.date))
                        Spacer()
                    }
                    .padding()
                    .cornerRadius(10)
                    .contentShape(Rectangle())
                    .onTapGesture { showDatePicker = true }
                    
                    // Botón para seleccionar prioridad
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
                
                // Botón para agregar la tarea
                Button(action: {
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
                .disabled(!TaskCreateView.isValidName(newTask.title)) // El botón está desactivado si no se tiene un nombre válido
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(color: .gray.opacity(0.2), radius: 3)
            )
            // Pop-ups
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
