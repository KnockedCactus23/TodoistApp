//
//  PriorityPickerPopUp.swift
//  TodoistApp
//
//  Created by Sergio Rodríguez Pérez on 23/10/25.
//

import SwiftUI

struct PriorityPickerPopup: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var task: Task
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Priority.allCases, id: \.self) { priority in
                    priorityRow(priority)
                }
            }
            .navigationTitle("Seleccionar prioridad")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
        }
    }
    
    private func priorityRow(_ priority: Priority) -> some View {
        HStack {
            Circle()
                .fill(priority.color)
                .frame(width: 16, height: 16)
            
            Text(priority.text)
            
            Spacer()
            
            if task.priority == priority {
                Image(systemName: "checkmark")
                    .foregroundStyle(.background)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            task.priority = priority
            dismiss()
        }
    }
}

