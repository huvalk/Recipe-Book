//
//  RecipeTableViewCell.swift
//  Recipe-Book
//
//  Created by User on 15.10.2020.
//

import UIKit
import Cosmos

class FavoriteCell: UITableViewCell {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var ingridientCount: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var recipeImage: UIImageView!
    
    var recipesPresenter: RecipesPresenter?
    var indexPath: IndexPath?
    var recipeId: Int = 0
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        self.recipesPresenter?.deleteFromFavorites(recipeId: self.recipeId, indexPath: self.indexPath!)
    }
    
    func configure(recipe: Recipe) {
        self.recipeId = recipe.id
        
        self.recipeName?.text = recipe.title
        self.recipeTime?.text = String(recipe.cookingTime) + " мин"
        self.ingridientCount?.text = String(recipe.ingredients.count) + " ингредиентов"
        
        self.ratingView.rating = recipe.rating
        self.ratingView.settings.fillMode = .precise
        self.ratingView.settings.updateOnTouch = false
        
        if recipe.photo != "default" {
            let imageUrl = URL(string: recipe.photo)
            self.recipeImage.kf.setImage(with: imageUrl)
        }
    }
}
