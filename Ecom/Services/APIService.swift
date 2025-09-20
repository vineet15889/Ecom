import Foundation
import SwiftUI

class HTTP1URLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                self?.client?.urlProtocol(self!, didFailWithError: error)
                return
            }
            
            if let response = response {
                self?.client?.urlProtocol(self!, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            
            if let data = data {
                self?.client?.urlProtocol(self!, didLoad: data)
            }
            
            self?.client?.urlProtocolDidFinishLoading(self!)
        }
        task.resume()
    }
    
    override func stopLoading() {
        // No-op
    }
}

class APIService: ObservableObject {
    static let shared = APIService()
    
    private init() {}
    
    func fetchWardrobeItems() async throws -> [WardrobeItem] {
        guard let url = URL(string: "https://core-apis.a1apps.co/ios/interview-details") else {
            throw APIError.invalidURL
        }
        
        // Try with custom configuration first
        do {
            return try await fetchWithCustomConfig(url: url)
        } catch {
            // Fallback to default configuration
            print("Custom config failed, trying default: \(error)")
            return try await fetchWithDefaultConfig(url: url)
        }
    }
    
    private func fetchWithCustomConfig(url: URL) async throws -> [WardrobeItem] {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 30.0
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30.0
        config.timeoutIntervalForResource = 60.0
        config.waitsForConnectivity = true
        config.allowsCellularAccess = true
        config.httpMaximumConnectionsPerHost = 1
        config.httpShouldUsePipelining = false
        
        let session = URLSession(configuration: config)
        let (data, response) = try await session.data(for: request)
        
        return try processResponse(data: data, response: response)
    }
    
    private func fetchWithDefaultConfig(url: URL) async throws -> [WardrobeItem] {
        let (data, response) = try await URLSession.shared.data(from: url)
        return try processResponse(data: data, response: response)
    }
    
    private func processResponse(data: Data, response: URLResponse) throws -> [WardrobeItem] {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw APIError.serverError(httpResponse.statusCode)
        }
        
        let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
        return apiResponse.data.map { item in
            WardrobeItem(
                title: item.name,
                brand: "Pantaloons",
                price: 260.0,
                rating: 4.0,
                imageName: "",
                imageURL: item.image,
                category: "Summer"
            )
        }
    }
}

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(Int)
    case decodingError
    case networkTimeout
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .serverError(let code):
            return "Server error with code: \(code)"
        case .decodingError:
            return "Failed to decode response data"
        case .networkTimeout:
            return "Network request timed out"
        }
    }
}

struct APIResponse: Codable {
    let data: [APIItem]
}

struct APIItem: Codable {
    let name: String
    let image: String
}
