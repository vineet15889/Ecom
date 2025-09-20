//
//  ReusableButton.swift
//  Ecom
//
//  Created by Vineet Rai on 20-Sep-25.
//

import SwiftUI

struct ReusableButton: View {
    let title: String
    let action: () -> Void
    let style: ButtonStyle
    
    enum ButtonStyle {
        case primary
        case secondary
        case gradient
    }
    
    init(title: String, style: ButtonStyle = .primary, action: @escaping () -> Void) {
        self.title = title
        self.style = style
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(foregroundColor)
                .padding(.horizontal, 20)
                .padding(.vertical, 6)
                .background(backgroundView)
                .cornerRadius(20)
        }
    }
    
    private var foregroundColor: Color {
        switch style {
        case .primary:
            return .white
        case .secondary:
            return .primary
        case .gradient:
            return .white
        }
    }
    
    private var backgroundView: some View {
        Group {
            switch style {
            case .primary:
                Color.blue
            case .secondary:
                Color.clear
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.blue, lineWidth: 1)
                    )
            case .gradient:
                GradientPalette.buttonGradient
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ReusableButton(title: "Shop", style: .gradient) { }
        ReusableButton(title: "Primary", style: .primary) { }
        ReusableButton(title: "Secondary", style: .secondary) { }
    }
    .padding()
}
