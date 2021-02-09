//
//  RecipesPresenter.swift
//  Recipe-Book
//
//  Created by User on 16.10.2020.
//

import Foundation

protocol RecipesDelegate {
    func setRecipes(recipes: [RecipeList])
}

class RecipesPresenter {
    var delegate: RecipesDelegate
    
    init(delegate: RecipesDelegate) {
        self.delegate = delegate
    }
    
    func getRecipes() {
        var recipes: [RecipeList] = [[], []]
        
        print("in presenter")
        
        RecipesNetworkService.getRecipes(userId: 1) { (recipes, statusCode) in
            if (200...299) ~= statusCode {
                self.recipes[0] = recipes
            } else {
                print("status code: \(statusCode)")
            }
        }
        
        recipes[0] = [
            Recipe(id: 1, author: 1, name: "Рецепт 1", cookingTime: 30, ingridients: [], steps: [])
        ]
        
        self.delegate.setRecipes(recipes: recipes)
    }
}
