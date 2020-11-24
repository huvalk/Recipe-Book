//
//  SearchPresenter.swift
//  Recipe-Book
//
//  Created by User on 14.11.2020.
//

import Foundation

protocol SearchCellDelegate {
    func fillHeart()
}

class SearchCellPresenter {
    var delegate: SearchCellDelegate
    var recipeId: Int
    
    init(delegate: SearchCellDelegate, recipeId: Int) {
        self.delegate = delegate
        self.recipeId = recipeId
    }
    
    func addToFavorites() {
        RecipesNetworkService.addToFavorites(userId: 1, recipeId: self.recipeId) { (statusCode) in
            if (200...299) ~= statusCode {
                self.delegate.fillHeart()
            } else {
                print("add to favorites: code \(statusCode)")
            }
        }
    }
    
    func deleteFromFavorites() {
        RecipesNetworkService.deleteFromFavorites(userId: 1, recipeId: self.recipeId) { (statusCode) in
            if (200...299) ~= statusCode {
                print("delete from favorites: success")
            } else {
                print("delete from favorites: code \(statusCode)")
            }
        }
    }
}
