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
                Recipe(name: "Рецепт 1", time: "10 мин", ingridientCount: "10 ингридиентов"),
                Recipe(name: "Рецепт 2", time: "20 мин", ingridientCount: "20 ингридиентов"),
            ],
            [
                Recipe(name: "Рецепт 3", time: "30 мин", ingridientCount: "30 ингридиентов"),
            ]
        ]
        
        self.delegate.setRecipes(recipes: recipes)
    }
}
