//
//  RecipesNetworkService.swift
//  Recipe-Book
//
//  Created by User on 23.10.2020.
//

import Foundation

class RecipesNetworkService {
    
    static func getRecipes(userId: Int, completion: @escaping([Recipe], Int) -> ()) {
        let path = "/users/\(userId)/recipes"
        
        NetworkService.shared.getRequest(rawUrl: path, data: userId) { (responseData, statusCode) in
            do {
                completion(responseData, statusCode)
            } else {
                print("getRecipes error")
            }
        }
    }
}
