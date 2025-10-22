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
    var id : UUID
    var title : String
    var details : String
    var priority : Int
    var date : Date
    var isCompleted : Bool
    
    init(
        id: UUID = UUID(),
        title: String,
        details: String,
        priority: Int,
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
