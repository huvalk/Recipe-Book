//
//  RecipeInfoTableViewCell.swift
//  Recipe-Book
//
//  Created by User on 15.11.2020.
//

import UIKit
import Cosmos

class RecipeInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeBlock: UIView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeRating: CosmosView!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var ingredientsCount: UILabel!
    
    var recipePresenter: RecipePresenter?
    
    func configure(recipe: Recipe) {
        self.recipeName.text = recipe.title
        self.recipeTime.text = String(recipe.cookingTime) + " мин"
        self.ingredientsCount.text = String(recipe.ingredients.count) + " ингредиентов"
        
        self.recipeRating.rating = recipe.rating
        self.recipeRating.settings.fillMode = .precise
        self.recipeRating.didTouchCosmos = { [weak self] rating in
            self?.recipePresenter?.vote(recipeId: recipe.id, stars: lround(rating))
        }
        
        self.recipeBlock.layer.shadowOpacity = 0.2
        self.recipeBlock.layer.shadowColor = UIColor.black.cgColor
        self.recipeBlock.layer.shadowRadius = 2
        self.recipeBlock.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.recipeBlock.layer.masksToBounds = false
    }
    
    func setRating(rating: Double) {
        self.recipeRating.rating = rating
    }
}
