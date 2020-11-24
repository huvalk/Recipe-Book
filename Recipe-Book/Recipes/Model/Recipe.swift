//
//  Recipe.swift
//  Recipe-Book
//
//  Created by User on 16.10.2020.
//

import Foundation

struct Recipe: Codable {
    var id: Int
    var author: Int
    var title: String
    var cookingTime: Int
    var rating: Double
    var ingredients: [String]
    var steps: [String]
    var isFavorites: Bool
}

typealias RecipeList = [Recipe]

struct UserStars: Codable {
    var userId: Int
    var stars: Int
}

var emptyRecipe = Recipe(id: 0, author: 0, title: "", cookingTime: 0, rating: 0, ingredients: [], steps: [], isFavorites: false)
