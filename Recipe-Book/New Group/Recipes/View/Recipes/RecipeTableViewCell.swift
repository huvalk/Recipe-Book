//
//  RecipeTableViewCell.swift
//  Recipe-Book
//
//  Created by User on 15.10.2020.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var ingridientCount: UILabel!
    
    // func configure(with model: SomeModel) {
    // recipeName.text = model.name
    // recipeTime.text = model.time
    // ....
    // }
}
