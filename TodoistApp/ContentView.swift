//
//  ContentView.swift
//  TodoistApp
//
//  Created by Sergio Rodríguez Pérez on 22/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TaskHomeView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Task.self)
}
