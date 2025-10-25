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

    @State private var tempDate: Date // Variable temporal de la fecha
    
    // Inicializador
    init(task: Task) {
        self.task = task
        _tempDate = State(initialValue: task.date)
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                // Fondo
                LinearGradient(
                    colors: [.white, .red.opacity(0.3)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // Selector de Fecha
                    DatePicker("", selection: $tempDate, in:Date()..., displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .accentColor(Color(.red))
                        .labelsHidden()
                    Spacer()
                }
                .padding()
                .navigationTitle("Fecha")
                .navigationBarTitleDisplayMode(.inline)
                
                // Botones de guardar y cancelar
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") { dismiss() }
                            .tint(.red)
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Guardar") {
                            task.date = tempDate
                            dismiss()
                        }
                            .tint(.red)
                    }
                }
            }
        }
    }
}
