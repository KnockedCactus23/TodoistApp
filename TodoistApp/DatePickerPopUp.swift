//
//  DatePickerPopUp.swift
//  TodoistApp
//
//  Created by Sergio Rodríguez Pérez on 23/10/25.
//

import SwiftUI

struct DatePickerPopup: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var task: Task
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Selecciona nueva fecha")
                    .font(.headline)
                
                DatePicker("", selection: $task.date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                
                Spacer()
            }
            .padding()
            .navigationTitle("Cambiar fecha")
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
