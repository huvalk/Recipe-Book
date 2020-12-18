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
        self.delegate.setRecipes(recipes: MyRecipeDatabaseService.getMyRecipes())
    }
    
    func updateRecipes() {
        let userId = SettingsService.userModel.ID
        print("userId: \(userId)")
        
        RecipesNetworkService.getRecipes(userId: userId) { (recipes, statusCode) in
            if (200...299) ~= statusCode {
                MyRecipeDatabaseService.clearMyRecipes()
                
                for recipe in recipes {
                    MyRecipeDatabaseService.saveMyRecipe(recipe)
                }
            } else {
                print("get recipes: code \(statusCode)")
            }
        }
    }
    
    func getFavorites() {
        self.delegate.setFavorites(favorites: FavoriteDatabaseService.getFavorites())
    }
    
    func updateFavorites() {
        RecipesNetworkService.getFavorites() { (favorites, statusCode) in
            if (200...299) ~= statusCode {
                FavoriteDatabaseService.clearFavorites()
                
                for favorite in favorites {
                    FavoriteDatabaseService.saveFavorite(favorite)
                }
            } else {
                print("get favorites: code \(statusCode)")
            }
        }
    }
    
    func deleteFromFavorites(recipeId: Int, indexPath: IndexPath) {
        RecipesNetworkService.deleteFromFavorites(recipeId: recipeId) { (statusCode) in
            print("delete from favorites: code \(statusCode)")
        }
        
        if FavoriteDatabaseService.deleteFavorite(recipeId) {
            self.delegate.deleteCell(recipeId: recipeId, indexPath: indexPath)
        }
    }
}
