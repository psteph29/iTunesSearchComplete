//
//  StoreItemController.swift
//  iTunesSearch
//
//  Created by Paige Stephenson on 4/21/23.
//

import Foundation
import UIKit

class StoreItemController {
    
    enum SearchItemError: Error, LocalizedError {
        case itemsNotFound
        case imageDataMissing
    }
    
    func fetchItems(matching query: [String: String]) async throws -> [StoreItem] {
        let baseURL = "https://itunes.apple.com/search"
        
        var urlComponents = URLComponents(string: baseURL)!
        
        urlComponents.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw SearchItemError.itemsNotFound
        }
        print(data.prettyPrintedJSONString())
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(SearchResponse.self, from: data)
        
            return searchResponse.results
        
    }
    
    func fetchImage(from url: URL) async throws -> UIImage {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw SearchItemError.imageDataMissing
        }
        
        guard let image = UIImage(data: data) else {
            throw SearchItemError.imageDataMissing
        }
        return image
    }
}
    



extension Data {
    func prettyPrintedJSONString() {
        guard
            let jsonObject = try?
                JSONSerialization.jsonObject(with: self, options: []),
            let jsonData = try?
                JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
            let prettyJSONString = String(data: jsonData, encoding: .utf8) else {
            print("Failed to read JSON Object.")
            return
        }
        print(prettyJSONString)
        
    }
}


