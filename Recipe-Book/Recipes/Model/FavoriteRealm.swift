//
//  MyProductRealm.swift
//  Recipe-Book
//
//  Created by User on 15.12.2020.
//

import Foundation
import RealmSwift

class FavoriteRealm: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var author: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var cookingTime: Int = 0
    @objc dynamic var rating: Double = 0
    @objc dynamic var photo: String = ""
    let ingredients: List<String> = List<String>()
    let steps: List<String> = List<String>()
    
    static func create(recipe: Recipe) -> FavoriteRealm {
        let favorite = FavoriteRealm()
        
        favorite.id = recipe.id
        favorite.author = recipe.author
        favorite.title = recipe.title
        favorite.cookingTime = recipe.cookingTime
        favorite.rating = recipe.rating
        favorite.photo = recipe.photo
        for ingredient in recipe.ingredients {
            favorite.ingredients.append(ingredient)
        }
        for step in recipe.steps {
            favorite.steps.append(step)
        }
        
        return favorite
    }
    
    func toRecipe() -> Recipe {
        return Recipe(id: self.id, author: self.author, title: self.title, cookingTime: self.cookingTime, rating: self.rating, ingredients: Array(self.ingredients), steps: Array(self.steps), isFavorites: true, photo: self.photo)
    }
}
