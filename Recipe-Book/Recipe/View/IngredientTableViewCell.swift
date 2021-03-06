//
//  IngridientTableViewCell.swift
//  Recipe-Book
//
//  Created by User on 17.10.2020.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ingredientName: UILabel!
    
    func configure(name: String) {
        self.ingredientName.text = (name.first?.uppercased() ?? "") + name.dropFirst()
    }
}
