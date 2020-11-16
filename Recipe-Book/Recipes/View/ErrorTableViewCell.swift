//
//  RecipeTableViewCell.swift
//  Recipe-Book
//
//  Created by User on 15.10.2020.
//

import UIKit
import Cosmos

class ErrorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var errorText: UILabel!
    
    func configure(text: String) {
        self.errorText.text = text
    }
}
