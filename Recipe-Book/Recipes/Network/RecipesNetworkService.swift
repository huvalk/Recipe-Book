//
//  RecipesNetworkService.swift
//  Recipe-Book
//
//  Created by User on 23.10.2020.
//

import Foundation

class RecipesNetworkService {
    
    static func getRecipes(userId: Int, completion: @escaping(RecipeList, Int) -> ()) {
        let path = "/users/\(userId)/recipes"
        
        NetworkService.shared.getRequest(rawUrl: path) { (responseData, statusCode) in
            do {
                let recipes = try JSONDecoder().decode(RecipeList.self, from: responseData)
                completion(recipes, statusCode)
            } catch {
                print(error)
            }
        }
    }
    
    static func getFavorites(userId: Int, completion: @escaping(RecipeList, Int) -> ()) {
        let path = "/users/\(userId)/favorites"
        
        NetworkService.shared.getRequest(rawUrl: path) { (responseData, statusCode) in
            do {
                let favorites = try JSONDecoder().decode(RecipeList.self, from: responseData)
                completion(favorites, statusCode)
            } catch {
                print(error)
            }
        }
    }
}
