//
//  EditTaskPopUp.swift
//  TodoistApp
//
//  Created by Sergio Rodríguez Pérez on 23/10/25.
//

import SwiftUI
import SwiftData

struct EditTaskPopup: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Bindable var task: Task
    
    @State private var tempTitle: String
    @State private var tempDetails: String
    
    @State private var errorMessage: String?
    @State private var showErrorAlert = false
    
    // Inicializador para asignar valores iniciales a las variables temporales
    init(task: Task) {
        self._task = Bindable(task)
        _tempTitle = State(initialValue: task.title)
        _tempDetails = State(initialValue: task.details)
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
             
                VStack(alignment: .leading, spacing: 20){
                    // TITULO DE LA TAREA
                    HStack {
                        Circle()
                            .fill(task.priority.color)
                            .frame(width: 20, height: 20)
                            .opacity(0.4)
                        
                        TextField("Nombre de la tarea", text: $tempTitle)
                            .textFieldStyle(.plain)
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    
                    // DESCRIPCION
                    HStack {
                        Image(systemName: "text.alignleft")
                            .foregroundColor(.gray)
                        
                        TextField("Descripción", text: $tempDetails)
                            .textFieldStyle(.plain)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                }
                .padding(.top, 30)
                .padding(.horizontal, 30)
                .navigationTitle("Editar Tarea")
                .navigationBarTitleDisplayMode(.inline)
                
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") { dismiss() }
                            .tint(.red)
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Guardar") {
                            task.title = tempTitle
                            task.details = tempDetails
                            
                            do {
                                try context.save()
                                dismiss()
                            } catch {
                                // Muestra el error al usuario
                                errorMessage = "Error eliminando la tarea: \(error.localizedDescription)"
                                showErrorAlert = true
                            }
                        }
                        .tint(.red)
                        .disabled(!TaskCreateView.isValidName(tempTitle))
                    }
                }
                .alert(isPresented: $showErrorAlert) {
                    Alert(
                        title: Text("¡Oops!"),
                        message: Text(errorMessage ?? "Ha ocurrido un error"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
}
