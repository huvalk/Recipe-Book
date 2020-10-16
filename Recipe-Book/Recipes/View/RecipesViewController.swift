//
//  RecipesViewController.swift
//  Recipe-Book
//
//  Created by User on 15.10.2020.
//

import UIKit

class RecipesViewContoller: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var recipesPresenter: RecipesPresenter?
    
    var recipes: [RecipeList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recipesPresenter = RecipesPresenter(delegate: self)
        
        self.recipesPresenter?.getRecipes()
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
        
        cell.recipeName?.text = self.recipes[indexPath.section][indexPath.item].name
        cell.recipeTime?.text = self.recipes[indexPath.section][indexPath.item].time
        cell.ingridientCount?.text = self.recipes[indexPath.section][indexPath.item].ingridientCount
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension RecipesViewContoller: RecipesDelegate {
    func setRecipes(recipes: [RecipeList]) {
        self.recipes = recipes
    }
}
