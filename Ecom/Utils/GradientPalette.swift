//
//  GradientPalette.swift
//  Ecom
//
//  Created by Vineet Rai on 20-Sep-25.
//

import SwiftUI

struct GradientPalette {
    static let primary = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 73/255, green: 0/255, blue: 92/255),
            Color(red: 255/255, green: 0/255, blue: 0/255),
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let cardBackground = LinearGradient(
        colors: [Color.white, Color.white.opacity(0.95)],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let buttonGradient = LinearGradient(
        colors: [Color(red: 0.9, green: 0.2, blue: 0.3), Color(red: 0.4, green: 0.1, blue: 0.6)],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    static let headerGradient = LinearGradient(
        colors: [
            Color(red: 0.2, green: 0.1, blue: 0.4),
            Color(red: 0.8, green: 0.2, blue: 0.4),
            Color.white
        ],
        startPoint: .top,
        endPoint: .bottom
    )
}
