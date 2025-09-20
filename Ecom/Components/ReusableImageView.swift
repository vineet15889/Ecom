//
//  ReusableImageView.swift
//  Ecom
//
//  Created by Vineet Rai on 20-Sep-25.
//

import SwiftUI

struct ReusableImageView: View {
    let imageName: String
    let imageURL: String?
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    let contentMode: ContentMode
    
    init(
        imageName: String,
        imageURL: String? = nil,
        width: CGFloat = 80,
        height: CGFloat = 80,
        cornerRadius: CGFloat = 8,
        contentMode: ContentMode = .fill
    ) {
        self.imageName = imageName
        self.imageURL = imageURL
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.contentMode = contentMode
    }
    
    var body: some View {
        Group {
            if let imageURL = imageURL, !imageURL.isEmpty {
                CachedAsyncImage(urlString: imageURL)
                    .aspectRatio(contentMode: contentMode)
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(cornerRadius)
            } else {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(cornerRadius)
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ReusableImageView(imageName: "sample1", width: 100, height: 100)
        ReusableImageView(imageName: "sample2", width: 80, height: 80, cornerRadius: 12)
    }
    .padding()
}
