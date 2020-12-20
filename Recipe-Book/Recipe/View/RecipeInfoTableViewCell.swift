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
    
    @IBAction func toListButtonPressed(_ sender: Any) {
        for ingredient in recipe.ingredients {
            let ingredientArray = ingredient.components(separatedBy: " - ")
            let name = ingredientArray[0]
            let amountArray = ingredientArray[1].components(separatedBy: " ")
            let amount = Double(amountArray[0]) ?? 0
            
            let amountType: Ingredient.AmountType
            switch amountArray[1] {
            case "кг":
                amountType = Ingredient.AmountType.kgramm
            case "г":
                amountType = Ingredient.AmountType.gramm
            case "л":
                amountType = Ingredient.AmountType.litr
            case "мл":
                amountType = Ingredient.AmountType.mlitr
            default:
                amountType = Ingredient.AmountType.count
            }
            
            let product = Product(name: name, amountType: amountType, amount: amount, bought: false)
            
            ShoppingDatabaseService.saveProduct(product)
        }
    }
    
    var recipePresenter: RecipePresenter?
    var recipeInfoCellPresenter: RecipeInfoCellPresenter?
    var isFavorite: Bool = false
    var recipe: Recipe = emptyRecipe
    
    func configure(recipe: Recipe) {
        self.recipe = recipe
        
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
        
        if recipe.photo != "default" {
            print(recipe.photo)
            let imageUrl = URL(string: recipe.photo)
            self.recipeImage.kf.setImage(with: imageUrl)
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
