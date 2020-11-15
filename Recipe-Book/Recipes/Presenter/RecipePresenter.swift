//
//  RecipesPresenter.swift
//  Recipe-Book
//
//  Created by User on 16.10.2020.
//

import Foundation

protocol RecipeDelegate {
    func setRating(rating: Double)
}

class RecipePresenter {
    var delegate: RecipeDelegate
    
    init(delegate: RecipeDelegate) {
        self.delegate = delegate
    }
    
    func vote(recipeId: Int, stars: Int) {
        let userStars: UserStars = UserStars(userId: 1, stars: stars)
        
        RecipesNetworkService.vote(recipeId: recipeId, userStars: userStars) { (rating, statusCode) in
            if (200...299) ~= statusCode {
                self.delegate.setRating(rating: rating)
            } else {
                print("status code: \(statusCode)")
            }
        }
    }
}
