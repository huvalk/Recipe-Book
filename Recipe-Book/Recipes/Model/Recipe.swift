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
    let ingredients: [String]
    let steps: [String]
}

typealias RecipeList = [Recipe]
