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
    
    static func vote(recipeId: Int, userStars: UserStars, completion: @escaping(Double, Int) -> ()) {
        let path = "/recipe/\(recipeId)/vote"
        
        var jsonData = Data()
        do {
            jsonData = try JSONEncoder().encode(userStars)
        } catch {
            print("json serialization error")
        }

        NetworkService.shared.postRequest(rawUrl: path, data: jsonData) { (responseData, statusCode) in
            do {
                let rating = try JSONDecoder().decode(Double.self, from: responseData)
                completion(rating, statusCode)
                
                print("voted: \(userStars.stars)")
                print("rating: \(rating)")
            } catch {
                print(error)
            }
        }
    }
}
