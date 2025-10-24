//
//  TodoistAppApp.swift
//  TodoistApp
//
//  Created by Sergio Rodríguez Pérez on 22/10/25.
//

import SwiftUI
import SwiftData

@main
struct TodoistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Task.self)
        }
    }
}
