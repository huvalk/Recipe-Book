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
        
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.recipesPresenter?.getRecipes()
        self.recipesPresenter?.getFavorites()
    }
    
    @objc func reloadData(refreshControl: UIRefreshControl) {
        self.recipesPresenter?.updateRecipes()
        self.recipesPresenter?.getRecipes()
        
        self.recipesPresenter?.updateFavorites()
        self.recipesPresenter?.getFavorites()
        
        refreshControl.endRefreshing()
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
        let count = recipes[section].count
        
        return (count == 0) ? 1 : count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if recipes[indexPath.section].count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Error Cell") as! ErrorTableViewCell
            
            if indexPath.section == 0 {
                cell.configure(text: "Вы еще не добавляли рецепты в избранное")
            } else {
                cell.configure(text: "Вы еще не создавали рецепты")
            }

            return cell
        }
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Favorite Cell") as! FavoriteCell
            
            let recipe = self.recipes[indexPath.section][indexPath.item]
            cell.configure(recipe: recipe)
            cell.recipesPresenter = self.recipesPresenter
            cell.indexPath = indexPath
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "My Recipe Cell") as! RecipeTableViewCell
            
            let recipe = self.recipes[indexPath.section][indexPath.item]
            cell.configure(recipe: recipe)
            
            return cell

        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let recipeId = self.recipes[indexPath.section][indexPath.item].id
            
            self.recipesPresenter?.deleteRecipe(id: recipeId)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier?.starts(with: "show") == true {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let recipe = recipes[indexPath.section][indexPath.item]
            
            let destination = segue.destination as! RecipeViewController
            destination.recipe = recipe
            
            if segue.identifier == "showMyRecipe" {
                destination.showLike = false
            }
        }
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
    
    func deleteCell(recipeId: Int) {
        if let index = self.recipes[0].firstIndex(where: {$0.id == recipeId}) {
            self.recipes[0].remove(at: index)
        }
        if let index = self.recipes[1].firstIndex(where: {$0.id == recipeId}) {
            self.recipes[1].remove(at: index)
        }
        self.tableView.reloadData()
    }
}
