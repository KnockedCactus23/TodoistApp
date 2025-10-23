//
//  EditTaskPopUp.swift
//  TodoistApp
//
//  Created by Sergio Rodríguez Pérez on 23/10/25.
//

import SwiftUI

struct EditTaskPopup: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var task: Task
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Detalles de la tarea") {
                    TextField("Título", text: $task.title)
                    TextField("Descripción", text: $task.details, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                }
            }
            .navigationTitle("Editar tarea")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") { dismiss() }
                }
            }
        }
    }
}
