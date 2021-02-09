//
//  RecipesNetworkService.swift
//  Recipe-Book
//
//  Created by User on 23.10.2020.
//

import Foundation

class RecipesNetworkService {
    
    static func getRecipes(completion: @escaping(RecipeList, Int) -> ()) {
        let path = "/recipe"
        
        NetworkService.shared.getRequest(rawUrl: path) { (responseData, statusCode) in
            do {
                let recipes = try JSONDecoder().decode(RecipeList.self, from: responseData)
                completion(recipes, statusCode)
            } catch {
                print(error)
            }
        }
    }
    
    static func deleteRecipe(id: Int, userId: Int, completion: @escaping(Int) -> ()) {
        let path = "/recipe/\(id)"
        
        NetworkService.shared.deleteRequest(rawUrl: path) { (responseData, statusCode) in
            completion(statusCode)
        }
    }
    
    static func getFavorites(completion: @escaping(RecipeList, Int) -> ()) {
        let path = "/favorites"
        
        NetworkService.shared.getRequest(rawUrl: path) { (responseData, statusCode) in
            do {
                let favorites = try JSONDecoder().decode(RecipeList.self, from: responseData)
                completion(favorites, statusCode)
            } catch {
                print(error)
            }
        }
    }
    
    static func addToFavorites(recipeId: Int, completion: @escaping(Int) -> ()) {
        let path = "/favorites/\(recipeId)/add"
        
        NetworkService.shared.postRequest(rawUrl: path, data: Data()) { (responseData, statusCode) in
            do {
                completion(statusCode)
            } catch {
                print(error)
            }
        }
    }
    
    static func deleteFromFavorites(recipeId: Int, completion: @escaping(Int) -> ()) {
        let path = "/favorites/\(recipeId)/delete"
        
        NetworkService.shared.postRequest(rawUrl: path, data: Data()) { (responseData, statusCode) in
            do {
                completion(statusCode)
            } catch {
                print(error)
            }
        }
    }

}
