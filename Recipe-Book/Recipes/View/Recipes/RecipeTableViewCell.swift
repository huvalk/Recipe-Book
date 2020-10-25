//
//  RecipeTableViewCell.swift
//  Recipe-Book
//
//  Created by User on 15.10.2020.
//

import UIKit
import Cosmos

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var ingridientCount: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
}
