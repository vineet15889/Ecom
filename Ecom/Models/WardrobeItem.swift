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
    let category: String
}

struct WardrobeCategory: Identifiable, Codable {
    var id = UUID()
    let name: String
    let itemCount: Int
    let items: [WardrobeItem]
}
