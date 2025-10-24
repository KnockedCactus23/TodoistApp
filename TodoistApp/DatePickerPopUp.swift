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
    
    // Variable temporal de la fecha
    @State private var tempDate: Date
    
    init(task: Task) {
        self.task = task
        _tempDate = State(initialValue: task.date)
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                // Fondo gradiente
                LinearGradient(
                    colors: [.white, .red.opacity(0.3)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    DatePicker("", selection: $tempDate, in:Date()..., displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .accentColor(Color(.red))
                        .labelsHidden()
                    Spacer()
                }
                .padding()
                .navigationTitle("Fecha")
                .navigationBarTitleDisplayMode(.inline)
                
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
