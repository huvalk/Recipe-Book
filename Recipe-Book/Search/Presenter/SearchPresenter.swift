//
//  SearchPresenter.swift
//  Recipe-Book
//
//  Created by User on 14.11.2020.
//

import Foundation

protocol SearchDelegate {
    func setRecipes(searchResult: SearchResult)
    func addRecipes(searchResult: SearchResult)
    func endSearching()
}

class SearchPresenter {
    var delegate: SearchDelegate
    
    init(delegate: SearchDelegate) {
        self.delegate = delegate
    }
    
    func findRecipes(text: String, page: Int) {
        SearchNetworkService.findRecipes(text: text, page: page) { (searchResult, statusCode) in
            if (200...299) ~= statusCode {
                if page == 1 {
                    self.delegate.setRecipes(searchResult: searchResult)
                } else {
                    self.delegate.addRecipes(searchResult: searchResult)
                }
            } else {
                self.delegate.endSearching()
                print("status code: \(statusCode)")
            }
        }
    }
}
