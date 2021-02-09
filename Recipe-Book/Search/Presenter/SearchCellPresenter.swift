//
//  SearchPresenter.swift
//  Recipe-Book
//
//  Created by User on 14.11.2020.
//

import Foundation

protocol SearchCellDelegate {
    func fillHeart()
    func unfillHeart()
}

class SearchCellPresenter {
    var delegate: SearchCellDelegate
    var recipe: Recipe
    
    init(delegate: SearchCellDelegate, recipe: Recipe) {
        self.delegate = delegate
        self.recipe = recipe
    }
    
    func addToFavorites() {
        RecipesNetworkService.addToFavorites(recipeId: self.recipe.id) { (statusCode) in
            print("add to favorites: code \(statusCode)")
        }
        
        if FavoriteDatabaseService.saveFavorite(recipe) != nil {
            self.delegate.fillHeart()
        }
    }
    
    func deleteFromFavorites() {
        RecipesNetworkService.deleteFromFavorites(recipeId: recipe.id) { (statusCode) in
            print("delete from favorites: code \(statusCode)")
        }
        
        if FavoriteDatabaseService.deleteFavorite(recipe.id) {
            self.delegate.unfillHeart()
        }
    }
}
