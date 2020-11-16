//
//  RecipesNetworkService.swift
//  Recipe-Book
//
//  Created by User on 23.10.2020.
//

import Foundation

class RecipeNetworkService {
        
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
