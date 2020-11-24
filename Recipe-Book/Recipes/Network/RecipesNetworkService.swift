//
//  RecipesNetworkService.swift
//  Recipe-Book
//
//  Created by User on 23.10.2020.
//

import Foundation

struct UserId: Encodable {
    var id: Int
}

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
    
    static func addToFavorites(userId: Int, recipeId: Int, completion: @escaping(Int) -> ()) {
        let path = "/favorites/\(recipeId)/add"
        
        let data = UserId(id: 1)
        var jsonData = Data()
        do {
            jsonData = try JSONEncoder().encode(data)
        } catch {
            print(error)
        }
        
        NetworkService.shared.postRequest(rawUrl: path, data: jsonData) { (responseData, statusCode) in
            do {
                completion(statusCode)
            } catch {
                print(error)
            }
        }
    }
    
    static func deleteFromFavorites(userId: Int, recipeId: Int, completion: @escaping(Int) -> ()) {
        let path = "/favorites/\(recipeId)/delete"
        
        let data = UserId(id: 1)
        var jsonData = Data()
        do {
            jsonData = try JSONEncoder().encode(data)
        } catch {
            print(error)
        }
        
        NetworkService.shared.postRequest(rawUrl: path, data: jsonData) { (responseData, statusCode) in
            do {
                completion(statusCode)
            } catch {
                print(error)
            }
        }
    }

}
