//
//  SearchNetworkService.swift
//  Recipe-Book
//
//  Created by User on 14.11.2020.
//

import Foundation

class SearchNetworkService {
    
    static func findRecipes(text: String, completion: @escaping(RecipeList, Int) -> ()) {
        let textEncoded = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let path = "/search?text=\(textEncoded ?? "")"
        
        NetworkService.shared.getRequest(rawUrl: path) { (responseData, statusCode) in
            do {
                let recipes = try JSONDecoder().decode(RecipeList.self, from: responseData)
                completion(recipes, statusCode)
            } catch {
                print(error)
            }
        }
    }
}
