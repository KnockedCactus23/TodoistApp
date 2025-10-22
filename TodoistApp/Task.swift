//
//  Task.swift
//  TodoistApp
//
//  Created by Sergio Rodríguez Pérez on 22/10/25.
//

import Foundation
import SwiftData

@Model
public class Task{
    enum Priority: Int, Codable {
        case low = 1
        case medium = 2
        case high = 3
    }
    
    var id : UUID
    var title : String
    var details : String
    var priority : Priority
    var date : Date
    var isCompleted : Bool
    
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
