//
//  Recipe.swift
//  Recipe-Book
//
//  Created by User on 16.10.2020.
//

import Foundation

struct Recipe {
    var id: Int
    var author: Int
    var name: String
    var cookingTime: Int
    let ingridients: [String]
    let steps: [String]
}

typealias RecipeList = [Recipe]
