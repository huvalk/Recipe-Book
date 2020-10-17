//
//  Recipe.swift
//  Recipe-Book
//
//  Created by User on 16.10.2020.
//

import Foundation

struct Recipe {
    let name: String?
    let time: String?
    let ingridients: [String]?
    let steps: [String]?
}

typealias RecipeList = [Recipe]

let mockRecipes: [RecipeList] = [
    [
        Recipe(name: "Рецепт 1", time: "10 мин", ingridients: ["Ингридиент 1 - 1 шт", "Ингридиент 2 - 2 шт"], steps: ["Описание шага 1", "Описание шага 2", "Описание шага 3", "Описание шага 4", "Описание шага 5"]),
    ],
    [
        Recipe(name: "Рецепт 2", time: "30 мин", ingridients: ["Ингридиент 1 - 1 шт"], steps: ["Описание шага 1"]),
    ]
]
