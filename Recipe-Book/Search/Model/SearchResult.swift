//
//  SearchResult.swift
//  Recipe-Book
//
//  Created by User on 16.12.2020.
//

import Foundation

struct SearchResult: Codable {
    var recipes: RecipeList
    var hasNextPage: Bool
}
