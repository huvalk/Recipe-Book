//
//  RecipeViewController.swift
//  Recipe-Book
//
//  Created by User on 16.10.2020.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var ingridientCount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeName.text = recipe?.name
        recipeTime.text = recipe?.time
        ingridientCount.text = String(recipe?.ingridients?.count ?? 0) + " ингридиентов"
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.ingridients?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! IngridientTableViewCell
        
        cell.ingridientName?.text = recipe.ingridients?[indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 24
    }
}
