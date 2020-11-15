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
        searchField.delegate = self
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchPresenter?.findRecipes(text: textField.text ?? "")
        return true
    }
}
