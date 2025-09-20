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
    
    init(repository: WardrobeRepositoryProtocol = WardrobeRepository()) {
        self.repository = repository
    }
    
    func loadSummerItems() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let items = try await repository.fetchWardrobeItemsFromAPI()
                self.wardrobeItems = items
                self.isLoading = false
            } catch {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
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
