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
    public var id : UUID // id auto generado
    var title : String
    var details : String
    var priority : Priority
    var date : Date
    var isCompleted : Bool // para verificar si una tarea esta completa o no
    
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
