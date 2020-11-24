//
//  RecipeTableViewCell.swift
//  Recipe-Book
//
//  Created by User on 15.10.2020.
//

import UIKit
import Cosmos

class SearchRecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var ingridientCount: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var likeButton: UIButton!
    
    var searchCellPresenter: SearchCellPresenter?
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        self.searchCellPresenter?.addToFavorites()
    }
    
    func configure(recipe: Recipe) {
        self.searchCellPresenter = SearchCellPresenter(delegate: self, recipeId: recipe.id)
        
        self.recipeName?.text = recipe.title
        self.recipeTime?.text = String(recipe.cookingTime) + " мин"
        self.ingridientCount?.text = String(recipe.ingredients.count) + " ингредиентов"
        
        self.ratingView.rating = recipe.rating
        self.ratingView.settings.fillMode = .precise
        self.ratingView.settings.updateOnTouch = false
    }
}

extension SearchRecipeTableViewCell: SearchCellDelegate {
    func fillHeart() {
        self.likeButton.setImage(UIImage(named: "HeartFilled"), for: .normal)
    }
}
