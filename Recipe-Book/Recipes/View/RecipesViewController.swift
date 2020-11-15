//
//  RecipesViewController.swift
//  Recipe-Book
//
//  Created by User on 15.10.2020.
//

import UIKit
import Cosmos

class RecipesViewContoller: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var recipesPresenter: RecipesPresenter?
    var recipes: [RecipeList] = [[], []]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recipesPresenter = RecipesPresenter(delegate: self)
        
        self.recipesPresenter?.getRecipes()
        self.recipesPresenter?.getFavorites()
        
        self.tableView.tableFooterView = nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Избранные"
        case 1:
            return "Авторские"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! RecipeTableViewCell
        
        let recipe = self.recipes[indexPath.section][indexPath.item]
        cell.configure(recipe: recipe)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let recipe = recipes[indexPath.section][indexPath.item]
            
            let destination = segue.destination as! RecipeViewController
            destination.recipe = recipe
        }
    }
    
    func setRating(indexPath: IndexPath, rating: Double) {
        self.recipes[indexPath.section][indexPath.item].rating = rating
        
        self.tableView.reloadRows(at: [IndexPath](arrayLiteral: indexPath), with: UITableView.RowAnimation.none)
    }
}

extension RecipesViewContoller: RecipesDelegate {
    
    func setRecipes(recipes: RecipeList) {
        self.recipes[1] = recipes
        self.tableView.reloadData()
    }
    
    func setFavorites(favorites: RecipeList) {
        self.recipes[0] = favorites
        self.tableView.reloadData()
    }
}
