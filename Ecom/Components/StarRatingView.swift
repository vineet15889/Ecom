//
//  StarRatingView.swift
//  Ecom
//
//  Created by Vineet Rai on 20-Sep-25.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Double
    let maxRating: Int = 5
    let starSize: CGFloat
    let activeColor: Color
    let inactiveColor: Color
    
    init(rating: Double, starSize: CGFloat = 16, activeColor: Color = .red, inactiveColor: Color = .gray) {
        self.rating = rating
        self.starSize = starSize
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
    }
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...maxRating, id: \.self) { index in
                Image(systemName: index <= Int(rating) ? "star.fill" : "star")
                    .foregroundColor(index <= Int(rating) ? activeColor : inactiveColor)
                    .font(.system(size: starSize))
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        StarRatingView(rating: 4.0)
        StarRatingView(rating: 3.0)
        StarRatingView(rating: 5.0)
    }
    .padding()
}
