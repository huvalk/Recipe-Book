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
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        if isFavorite {
            self.recipeInfoCellPresenter?.deleteFromFavorites()
        } else {
            self.recipeInfoCellPresenter?.addToFavorites()
        }
    }
    
    var recipePresenter: RecipePresenter?
    var recipeInfoCellPresenter: RecipeInfoCellPresenter?
    var isFavorite: Bool = false
    
    func configure(recipe: Recipe) {
        self.recipeInfoCellPresenter = RecipeInfoCellPresenter(delegate: self, recipe: recipe)
        
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
        
        self.isFavorite = recipe.isFavorites
        if recipe.isFavorites {
            self.fillHeart()
        } else {
            self.unfillHeart()
        }
    }
    
    func hideLike() {
        print("hide")
        self.likeButton.isHidden = true
    }
    
    func setRating(rating: Double) {
        self.recipeRating.rating = rating
    }
}

extension RecipeInfoTableViewCell: RecipeInfoCellDelegate {
    
    func fillHeart() {
        self.likeButton.setImage(UIImage(named: "HeartFilled"), for: .normal)
        self.isFavorite = true
    }
    
    func unfillHeart() {
        self.likeButton.setImage(UIImage(named: "Heart"), for: .normal)
        self.isFavorite = false
    }}
