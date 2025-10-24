//
//  TodoistAppTests.swift
//  TodoistAppTests
//
//  Created by Sergio Rodríguez Pérez on 24/10/25.
//

import Testing
import Foundation
@testable import TodoistApp

struct TodoistAppTests {

    // Test 1. Comprobar que no guarde tareas sin nombre
    @Test("El nombre no debe estar vacío ni en blanco")
    func testNameValidation() async throws {
        #expect(TaskCreateView.isValidName("Tarea 1"))
        #expect(!TaskCreateView.isValidName(""))
        #expect(!TaskCreateView.isValidName(" "))
    }
    
    // Test 2. Comprueba que cada tarea se guarde con un ID único
    @Test("Cada tarea tiene un ID único")
    func testTaskIDUnique() {
        let task1 = Task(title: "A", details: "", priority: .none, date: .now)
        let task2 = Task(title: "B", details: "", priority: .none, date: .now)

        #expect(task1.id != task2.id)
    }
}
