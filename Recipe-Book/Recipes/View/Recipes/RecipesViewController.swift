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
        
        cell.recipeName?.text = recipe.title
        cell.recipeTime?.text = String(recipe.cookingTime) + " мин"
        cell.ingridientCount?.text = String(recipe.ingredients.count) + " ингридиентов"
        
        cell.ratingView.rating = recipe.rating
        cell.ratingView.settings.fillMode = .precise
        cell.ratingView.settings.updateOnTouch = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = UIView()
//
//        let headerLabel = UILabel(frame: CGRect(x: 8, y: 8, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
//        headerLabel.font = UIFont(name: "System", size: 18)
//        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
//        headerLabel.sizeToFit()
//        
//        header.addSubview(headerLabel)
//        return header
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let recipe = recipes[indexPath.section][indexPath.item]
            
            let destination = segue.destination as! RecipeViewController
            destination.recipe = recipe
            destination.recipesViewController = self
            destination.recipesIndexPath = indexPath
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
