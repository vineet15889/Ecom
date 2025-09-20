//
//  WardrobeItem.swift
//  Ecom
//
//  Created by Vineet Rai on 20-Sep-25.
//

import Foundation

struct WardrobeItem: Identifiable, Codable {
    var id = UUID()
    let title: String
    let brand: String
    let price: Double
    let rating: Double
    let imageName: String
    let imageURL: String?
    let category: String
    
    init(title: String, brand: String, price: Double, rating: Double, imageName: String, imageURL: String? = nil, category: String) {
        self.title = title
        self.brand = brand
        self.price = price
        self.rating = rating
        self.imageName = imageName
        self.imageURL = imageURL
        self.category = category
    }
}

struct WardrobeCategory: Identifiable, Codable {
    var id = UUID()
    let name: String
    let itemCount: Int
    let items: [WardrobeItem]
}
