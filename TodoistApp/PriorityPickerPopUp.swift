//
//  PriorityPickerPopUp.swift
//  TodoistApp
//
//  Created by Sergio Rodríguez Pérez on 23/10/25.
//

import SwiftUI

import SwiftUI

struct PriorityPickerPopup: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var priority: Priority   // Binding directo
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Lista de prioridades
                ForEach(Priority.allCases.sorted(by: { $0.rawValue > $1.rawValue }), id: \.self) { p in
                    HStack(spacing: 12) {
                        Image(systemName: "flag.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(p.color)
                        
                        Text(p.text)
                            .font(.title3)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        if priority == p {
                            Image(systemName: "checkmark")
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                    .background(Color.clear)
                    .onTapGesture {
                        withAnimation {
                            priority = p
                        }
                        dismiss()
                    }
                    
                    if p != Priority.allCases.first {
                        Divider()
                            .padding(.leading)
                    }
                }
                
                // Botón cancelar
                Button("Cancelar") {
                    dismiss()
                }
                .font(.title2)
                .background(Color.clear)
                .foregroundColor(.black)
                .padding(.top, 20)
            }
            .padding()
        }
    }
}
