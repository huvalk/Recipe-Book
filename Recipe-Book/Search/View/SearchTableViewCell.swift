//
//  SearchTableViewCell.swift
//  Recipe-Book
//
//  Created by User on 15.11.2020.
//

import UIKit

class SearchTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var searchField: UITextField!
    
    var searchPresenter: SearchPresenter?
    
    func configure() {
        self.searchField.delegate = self
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchPresenter?.findRecipes(text: textField.text ?? "")
        return true
    }
}
