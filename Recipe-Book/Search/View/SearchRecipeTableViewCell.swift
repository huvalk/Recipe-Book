//
//  RecipeTableViewCell.swift
//  Recipe-Book
//
//  Created by User on 15.10.2020.
//

import UIKit
import Cosmos
import Kingfisher

class SearchRecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var ingridientCount: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var recipeImage: UIImageView!
    
    var searchCellPresenter: SearchCellPresenter?
    var isFavorite: Bool = false
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        if !isFavorite {
            self.searchCellPresenter?.addToFavorites()
        } else {
            self.searchCellPresenter?.deleteFromFavorites()
        }
    }
    
    func configure(recipe: Recipe) {
        self.searchCellPresenter = SearchCellPresenter(delegate: self, recipe: recipe)
        
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
        
        if SettingsService.userModel == nil {
            self.likeButton.isHidden = true
        } else {
            self.isFavorite = recipe.isFavorites
            if self.isFavorite {
                self.fillHeart()
            } else {
                self.unfillHeart()
            }
        }
    }
}

extension SearchRecipeTableViewCell: SearchCellDelegate {
    func fillHeart() {
        self.likeButton.setImage(UIImage(named: "HeartFilled"), for: .normal)
        self.isFavorite = true
    }
    
    func unfillHeart() {
        self.likeButton.setImage(UIImage(named: "Heart"), for: .normal)
        self.isFavorite = false
    }
}
