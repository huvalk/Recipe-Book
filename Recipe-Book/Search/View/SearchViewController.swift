//
//  SearchViewController.swift
//  Recipe-Book
//
//  Created by User on 09.11.2020.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var searchPresenter: SearchPresenter?
    var recipes: RecipeList = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        searchPresenter = SearchPresenter(delegate: self)
        searchPresenter?.findRecipes(text: "")
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return recipes.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Search Cell") as! SearchTableViewCell
            
            cell.configure()
            cell.searchPresenter = searchPresenter
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Recipe Cell") as! RecipeTableViewCell
            
            let recipe = self.recipes[indexPath.item]
            
            cell.recipeName?.text = recipe.title
            cell.recipeTime?.text = String(recipe.cookingTime) + " мин"
            cell.ingridientCount?.text = String(recipe.ingredients.count) + " ингридиентов"
            
            cell.ratingView.rating = recipe.rating
            cell.ratingView.settings.fillMode = .precise
            cell.ratingView.settings.updateOnTouch = false
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension SearchViewController: SearchDelegate {
    
    func setRecipes(recipes: RecipeList) {
        self.recipes = recipes
        self.tableView.reloadData()
    }
}
