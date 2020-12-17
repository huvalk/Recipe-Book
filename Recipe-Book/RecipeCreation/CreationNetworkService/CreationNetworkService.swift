//
//  NetworkService.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 17.12.2020.
//

import Foundation

final class CreationNetworkService {
    private init() {}
    
    static func saveRecipe(_ recipe: Recipe, completion: @escaping(Recipe?, Int) -> ()) {
        let path = "/recipe"
        
        var data = Data()
        do {
            data = try JSONEncoder().encode(recipe)
        } catch {
            print("json serialization error")
            return
        }
        
        NetworkService.shared.postRequest(rawUrl: path, data: data) { (responseData, statusCode)  in
            if statusCode != 201 {
                completion(nil, statusCode)
            }
            
            do {
                let savedRecipe = try JSONDecoder().decode(Recipe.self, from: responseData)
                completion(savedRecipe, statusCode)
            } catch {
                print("Invalid recipe json")
            }
        }
    }
}
