//
//  TaskHomeView.swift
//  TodoistApp
//
//  Created by Sergio Rodríguez Pérez on 23/10/25.
//

import SwiftUI
import SwiftData

struct TaskHomeView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query(sort: \Task.date, order: .forward)
    private var tasks: [Task]
    
    @State private var showingCreateView = false

    @State private var selectedTask: Task? = nil
    
    // Manejo de errores
    @State private var errorMessage: String?
    @State private var showErrorAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo
                LinearGradient(
                    colors: [.white, .red.opacity(0.3)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            
                // Si las tareas están vacías, se muestra que no hay tareas por hacer
                if tasks.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 80))
                            .foregroundStyle(.red)
                            .opacity(0.7)
                        
                        Text("¡No hay tareas aún!\nDisfruta de tu día 😃")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .bold()
                    }
                } else {
                    // Se muestran en orden las tareas por hacer
                    List {
                        ForEach(tasks) { task in
                            TaskListView(task: task){
                                context.delete(task)
                                do {
                                    try context.save() // Guarda la tarea eliminada
                                } catch {
                                    // Muestra el error al usuario
                                    errorMessage = "Error eliminando la tarea: \(error.localizedDescription)"
                                    showErrorAlert = true
                                }
                            }
                                .listRowBackground(Color.clear)
                                // Controla la vista de edición al hacer clic en la tarea
                                .onTapGesture {
                                    selectedTask = task
                                }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                
                // Botón para agregar más tareas
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showingCreateView = true
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationTitle("Mis Tareas")

            .sheet(isPresented: $showingCreateView) {
                TaskCreateView(context: context)
                    .presentationDetents([.medium, .height(500)])
                    .presentationDragIndicator(.visible)
            }
            
            // Activar vista de edición
            .sheet(item: $selectedTask) { taskToEdit in
                TaskEditView(task: taskToEdit)
                    .presentationDetents([.height(350), .medium])
                    .presentationDragIndicator(.visible)
            }
            
            // Manejo de errores
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

#Preview{
    TaskHomeView()
        .modelContainer(for: Task.self)
}
