//
//  RecipeViewController.swift
//  Recipe-Book
//
//  Created by User on 16.10.2020.
//

import UIKit

class RecipeViewController: UIViewController {
    
    @IBOutlet weak var recipeName: UILabel!
    
    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeName.text = recipe?.name
    }
}
