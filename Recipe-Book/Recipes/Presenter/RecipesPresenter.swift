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
    func setRating(indexPath: IndexPath, rating: Double)
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
    
    func vote(recipeId: Int, stars: Int, indexPath: IndexPath) {
        let userStars: UserStars = UserStars(userId: 1, stars: stars)
        
        RecipesNetworkService.vote(recipeId: recipeId, userStars: userStars) { (rating, statusCode) in
            if (200...299) ~= statusCode {
                self.delegate.setRating(indexPath: indexPath, rating: rating)
            } else {
                print("status code: \(statusCode)")
            }
        }
    }
}
