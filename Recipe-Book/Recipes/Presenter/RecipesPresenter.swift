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
    func deleteCell(recipeId: Int, indexPath: IndexPath)
}

class RecipesPresenter {
    var delegate: RecipesDelegate
    
    init(delegate: RecipesDelegate) {
        self.delegate = delegate
    }
    
    func getRecipes() {
        print(SettingsService.userModel)
        RecipesNetworkService.getRecipes(userId: 1) { (recipes, statusCode) in
            if (200...299) ~= statusCode {
                self.delegate.setRecipes(recipes: recipes)
            } else {
                print("get recipes: code \(statusCode)")
            }
        }
    }
    
    func getFavorites() {
        RecipesNetworkService.getFavorites() { (favorites, statusCode) in
            if (200...299) ~= statusCode {
                self.delegate.setFavorites(favorites: favorites)
            } else {
                print("get favorites: code \(statusCode)")
            }
        }
    }
    
    func deleteFromFavorites(recipeId: Int, indexPath: IndexPath) {
        RecipesNetworkService.deleteFromFavorites(recipeId: recipeId) { (statusCode) in
            if (200...299) ~= statusCode {
                self.delegate.deleteCell(recipeId: recipeId, indexPath: indexPath)
            } else {
                print("delete from favorites: code \(statusCode)")
            }
        }
    }
}
