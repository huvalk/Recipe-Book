//
//  RecipeTableViewCell.swift
//  Recipe-Book
//
//  Created by User on 15.10.2020.
//

import UIKit
import Cosmos

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var ingridientCount: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        
    }
    
    func configure(recipe: Recipe) {
        self.recipeName?.text = recipe.title
        self.recipeTime?.text = String(recipe.cookingTime) + " мин"
        self.ingridientCount?.text = String(recipe.ingredients.count) + " ингредиентов"
        
        self.ratingView.rating = recipe.rating
        self.ratingView.settings.fillMode = .precise
        self.ratingView.settings.updateOnTouch = false
    }
}
