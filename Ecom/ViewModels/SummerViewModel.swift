//
//  SummerViewModel.swift
//  Ecom
//
//  Created by Vineet Rai on 20-Sep-25.
//

import Foundation
import SwiftUI

@MainActor
class SummerViewModel: ObservableObject {
    @Published var wardrobeItems: [WardrobeItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let repository: WardrobeRepositoryProtocol
    
    init(repository: WardrobeRepositoryProtocol = WardrobeRepository.shared) {
        self.repository = repository
    }
    
    func loadSummerItems() {
        isLoading = true
        errorMessage = nil
        
        // network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.wardrobeItems = self.repository.getWardrobeItems(for: "Summer")
            self.isLoading = false
        }
    }
    
    func getItemCount() -> Int {
        return wardrobeItems.count
    }
    
    func shopItem(_ item: WardrobeItem) {
        // shop action
        print("Shopping for item: \(item.title)")
    }
}
