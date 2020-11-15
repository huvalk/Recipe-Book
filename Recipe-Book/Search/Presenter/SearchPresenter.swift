//
//  SearchPresenter.swift
//  Recipe-Book
//
//  Created by User on 14.11.2020.
//

import Foundation

protocol SearchDelegate {
    func setRecipes(recipes: RecipeList)
}

class SearchPresenter {
    var delegate: SearchDelegate
    
    init(delegate: SearchDelegate) {
        self.delegate = delegate
    }
    
    func findRecipes(text: String) {
        SearchNetworkService.findRecipes(text: text) { (recipes, statusCode) in
            if (200...299) ~= statusCode {
                self.delegate.setRecipes(recipes: recipes)
            } else {
                print("status code: \(statusCode)")
            }
        }
    }
}
