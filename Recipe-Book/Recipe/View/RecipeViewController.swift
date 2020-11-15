//
//  RecipeViewController.swift
//  Recipe-Book
//
//  Created by User on 16.10.2020.
//

import UIKit
import Cosmos

class RecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!

    var recipe: Recipe?
    var recipePresenter: RecipePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recipePresenter = RecipePresenter(delegate: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return recipe?.ingredients.count ?? 0
        case 2:
            return recipe?.steps.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Recipe Info Cell") as! RecipeInfoTableViewCell
            
            cell.configure(recipe: recipe ?? emptyRecipe)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Ingredient Cell") as! IngredientTableViewCell
            
            cell.configure(name: recipe?.ingredients[indexPath.item] ?? "")
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Step Cell") as! StepTableViewCell
            
            cell.configure(number: indexPath.item + 1, text: recipe?.steps[indexPath.item] ?? "")
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension RecipeViewController: RecipeDelegate {
    
    func setRating(rating: Double) {
        self.recipe?.rating = rating
        self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
    }
}
