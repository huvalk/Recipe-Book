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
        
        self.searchPresenter = SearchPresenter(delegate: self)
        self.searchPresenter?.findRecipes(text: "")
        
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    @objc func reloadData(refreshControl: UIRefreshControl) {
        self.searchPresenter?.findRecipes(text: "")
        
        refreshControl.endRefreshing()
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
            cell.configure(recipe: recipe)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let recipe = recipes[indexPath.item]
            
            let destination = segue.destination as! RecipeViewController
            destination.recipe = recipe
        }
    }
}

extension SearchViewController: SearchDelegate {
    
    func setRecipes(recipes: RecipeList) {
        self.recipes = recipes
        self.tableView.reloadData()
    }
}
