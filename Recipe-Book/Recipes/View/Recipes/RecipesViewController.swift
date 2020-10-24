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
        
        cell.recipeName?.text = self.recipes[indexPath.section][indexPath.item].title
        cell.recipeTime?.text = String(self.recipes[indexPath.section][indexPath.item].cookingTime) + " мин"
        cell.ingridientCount?.text = String(self.recipes[indexPath.section][indexPath.item].ingredients.count) + " ингридиентов"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        
        let headerLabel = UILabel(frame: CGRect(x: 16, y: 4, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "System", size: 18)
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        header.addSubview(headerLabel)
        
        return header
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let recipe = recipes[indexPath.section][indexPath.item]
            
            let destination = segue.destination as! RecipeViewController
            destination.recipe = recipe
        }
    }
}

extension RecipesViewContoller: RecipesDelegate {
    
    func setRecipes(recipes: RecipeList) {
        self.recipes[1] = recipes
        print(recipes)
        self.tableView.reloadData()
    }
    
    func setFavorites(favorites: RecipeList) {
        self.recipes[0] = favorites
        self.tableView.reloadData()
    }
}
