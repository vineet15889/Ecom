//
//  WardrobeRepository.swift
//  Ecom
//
//  Created by Vineet Rai on 20-Sep-25.
//

import Foundation

protocol WardrobeRepositoryProtocol {
    func getWardrobeCategories() -> [WardrobeCategory]
    func getWardrobeItems(for category: String) -> [WardrobeItem]
    func fetchWardrobeItemsFromAPI() async throws -> [WardrobeItem]
}

class WardrobeRepository: WardrobeRepositoryProtocol {
    private let apiService = APIService.shared
    
    func getWardrobeCategories() -> [WardrobeCategory] {
        return [
            WardrobeCategory(
                name: "Summer",
                itemCount: 96,
                items: getSummerItems()
            ),
            WardrobeCategory(
                name: "Winter",
                itemCount: 45,
                items: getWinterItems()
            ),
            WardrobeCategory(
                name: "Casual",
                itemCount: 78,
                items: getCasualItems()
            )
        ]
    }
    
    func getWardrobeItems(for category: String) -> [WardrobeItem] {
        switch category.lowercased() {
        case "summer":
            return getSummerItems()
        case "winter":
            return getWinterItems()
        case "casual":
            return getCasualItems()
        default:
            return []
        }
    }
    
    private func getSummerItems() -> [WardrobeItem] {
        return [
            WardrobeItem(
                title: "Colorful floral summer",
                brand: "Pantaloons",
                price: 260.0,
                rating: 4.0,
                imageName: "1",
                category: "Summer"
            ),
            WardrobeItem(
                title: "Colorful white gown",
                brand: "Pantaloons",
                price: 260.0,
                rating: 4.0,
                imageName: "1",
                category: "Summer"
            ),
            WardrobeItem(
                title: "Colorful black top summer outfit",
                brand: "Pantaloons",
                price: 260.0,
                rating: 3.0,
                imageName: "1",
                category: "Summer"
            ),
            WardrobeItem(
                title: "Vibrant summer dress",
                brand: "Fashion Store",
                price: 180.0,
                rating: 4.5,
                imageName: "1",
                category: "Summer"
            ),
            WardrobeItem(
                title: "Beach ready outfit",
                brand: "Summer Collection",
                price: 220.0,
                rating: 4.2,
                imageName: "1",
                category: "Summer"
            )
        ]
    }
    
    private func getWinterItems() -> [WardrobeItem] {
        return [
            WardrobeItem(
                title: "Warm winter coat",
                brand: "Winter Wear",
                price: 350.0,
                rating: 4.3,
                imageName: "winter_outfit_1",
                category: "Winter"
            ),
            WardrobeItem(
                title: "Cozy sweater",
                brand: "Comfort Zone",
                price: 120.0,
                rating: 4.1,
                imageName: "winter_outfit_2",
                category: "Winter"
            )
        ]
    }
    
    private func getCasualItems() -> [WardrobeItem] {
        return [
            WardrobeItem(
                title: "Casual jeans and t-shirt",
                brand: "Everyday Wear",
                price: 85.0,
                rating: 3.8,
                imageName: "casual_outfit_1",
                category: "Casual"
            ),
            WardrobeItem(
                title: "Comfortable hoodie",
                brand: "Relaxed Style",
                price: 95.0,
                rating: 4.0,
                imageName: "casual_outfit_2",
                category: "Casual"
            )
        ]
    }
    
    func fetchWardrobeItemsFromAPI() async throws -> [WardrobeItem] {
        return try await apiService.fetchWardrobeItems()
    }
}
