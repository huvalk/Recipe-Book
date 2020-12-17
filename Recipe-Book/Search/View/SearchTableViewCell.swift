//
//  SearchTableViewCell.swift
//  Recipe-Book
//
//  Created by User on 15.11.2020.
//

import UIKit

class SearchTableViewCell: UITableViewCell, UITextFieldDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchPresenter: SearchPresenter?
    var controller: SearchViewController?
    
    func configure() {
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        controller?.pageNumber = 1
        
        self.searchPresenter?.findRecipes(text: searchText, page: 1)
    }
}
