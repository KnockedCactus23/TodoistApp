//
//  Task.swift
//  TodoistApp
//
//  Created by Sergio Rodríguez Pérez on 22/10/25.
//

import Foundation
import SwiftData

// Modelo utilizado para los datos
@Model
public class Task{
    @Attribute(.unique) public var id: UUID = UUID()
    @Attribute var title : String
    @Attribute var details : String
    @Attribute var priority : Priority
    @Attribute var date : Date
    @Attribute var isCompleted : Bool // para verificar si una tarea esta completa o no
    
    init(
        id: UUID = UUID(),
        title: String,
        details: String,
        priority: Priority,
        date: Date,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.title = title
        self.details = details
        self.priority = priority
        self.date = date
        self.isCompleted = isCompleted
    }
}
