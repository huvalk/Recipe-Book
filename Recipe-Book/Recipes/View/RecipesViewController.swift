//
//  RecipesViewController.swift
//  Recipe-Book
//
//  Created by User on 15.10.2020.
//

import UIKit

class RecipesViewContoller: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
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
        
        // let item: Recipe = recipes[indexPath.section][indexPath.item]
        // let model: SomeModel = SomeModel(with: item)
        // should use cell.configure(with: model)
        cell.recipeName?.text = self.recipes[indexPath.section][indexPath.item].name
        cell.recipeTime?.text = self.recipes[indexPath.section][indexPath.item].time
        cell.ingridientCount?.text = self.recipes[indexPath.section][indexPath.item].ingridientCount
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let recipe = recipes[indexPath.section][indexPath.item]
            
            let recipeDetail = segue.destination as! RecipeViewController
            recipeDetail.recipe = recipe
        }
    }
}

extension RecipesViewContoller: RecipesDelegate {
    func setRecipes(recipes: [RecipeList]) {
        self.recipes = recipes
        // tableView.reloadData() - for reload data in table view after set data
    }
}
