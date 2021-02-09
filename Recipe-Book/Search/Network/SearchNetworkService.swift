//
//  SearchNetworkService.swift
//  Recipe-Book
//
//  Created by User on 14.11.2020.
//

import Foundation

class SearchNetworkService {
    
    static func findRecipes(text: String, page: Int, completion: @escaping(SearchResult, Int) -> ()) {
        let textEncoded = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let path = "/search?text=\(textEncoded ?? "")&page=\(page)"
        
        NetworkService.shared.getRequest(rawUrl: path) { (responseData, statusCode) in
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: responseData)
                completion(searchResult, statusCode)
            } catch {
                print(error)
            }
        }
    }
}
