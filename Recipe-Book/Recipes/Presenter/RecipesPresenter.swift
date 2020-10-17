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
        let recipes: [RecipeList] = [
            [
                Recipe(name: "Рецепт 1", time: "10 мин", ingridients: ["1", "2", "3", "4"]),
                Recipe(name: "Рецепт 2", time: "20 мин", ingridients: ["2"]),
            ],
            [
                Recipe(name: "Рецепт 3", time: "30 мин", ingridients: ["3"]),
            ]
        ]
        
        self.delegate.setRecipes(recipes: recipes)
    }
}
