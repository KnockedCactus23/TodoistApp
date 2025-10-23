//
//  Priority.swift
//  TodoistApp
//
//  Created by Sergio Rodríguez Pérez on 23/10/25.
//

import Foundation
import SwiftUI

public enum Priority: Int, Codable, Sendable, CaseIterable {
    case low = 1
    case medium = 2
    case high = 3

    var text: String {
        switch self {
        case .high: return "Alta"
        case .medium: return "Media"
        case .low: return "Baja"
        }
    }

    var color: Color {
        switch self {
        case .high: return .red.opacity(0.8)
        case .medium: return .orange.opacity(0.8)
        case .low: return .blue.opacity(0.8)
        }
    }
}
