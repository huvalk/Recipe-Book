//
//  RecipesPresenter.swift
//  Recipe-Book
//
//  Created by User on 16.10.2020.
//

import Foundation

protocol RecipesDelegate {
    func setRecipes(recipes: RecipeList)
    func setFavorites(favorites: RecipeList)
}

class RecipesPresenter {
    var delegate: RecipesDelegate
    
    init(delegate: RecipesDelegate) {
        self.delegate = delegate
    }
    
    func getRecipes() {
        RecipesNetworkService.getRecipes(userId: 1) { (recipes, statusCode) in
            if (200...299) ~= statusCode {
                self.delegate.setRecipes(recipes: recipes)
            } else {
                print("status code: \(statusCode)")
            }
        }
    }
    
    func getFavorites() {
        RecipesNetworkService.getFavorites(userId: 1) { (favorites, statusCode) in
            if (200...299) ~= statusCode {
                self.delegate.setFavorites(favorites: favorites)
            } else {
                print("status code: \(statusCode)")
            }
        }
    }
}
