//
//  MyProductRealm.swift
//  Recipe-Book
//
//  Created by User on 15.12.2020.
//

import Foundation
import RealmSwift

class MyRecipeRealm: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var realmId = 0
    @objc dynamic var author: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var cookingTime: Int = 0
    @objc dynamic var rating: Double = 0
    @objc dynamic var photo: String = ""
    let ingredients: List<String> = List<String>()
    let steps: List<String> = List<String>()
    
    static func create(recipe: Recipe) -> MyRecipeRealm {
        let myRecipe = MyRecipeRealm()
        
        myRecipe.id = recipe.id
        myRecipe.author = recipe.author
        myRecipe.title = recipe.title
        myRecipe.cookingTime = recipe.cookingTime
        myRecipe.rating = recipe.rating
        myRecipe.photo = recipe.photo
        for ingredient in recipe.ingredients {
            myRecipe.ingredients.append(ingredient)
        }
        for step in recipe.steps {
            myRecipe.steps.append(step)
        }
        
        return myRecipe
    }
    
    func toRecipe() -> Recipe {
        return Recipe(id: self.id, author: self.author, title: self.title, cookingTime: self.cookingTime, rating: self.rating, ingredients: Array(self.ingredients), steps: Array(self.steps), isFavorites: true, photo: self.photo)
    }
}
