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
}

typealias RecipeList = [Recipe]

struct UserStars: Codable {
    var userId: Int
    var stars: Int
}
