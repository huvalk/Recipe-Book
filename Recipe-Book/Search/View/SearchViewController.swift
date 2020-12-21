//
//  SearchViewController.swift
//  Recipe-Book
//
//  Created by User on 09.11.2020.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchPresenter: SearchPresenter?
    var recipes: RecipeList = []
    var pageNumber: Int = 1
    var hasNextPage: Bool = false
    var isSearching: Bool = false
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.allowsSelection = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        self.searchPresenter = SearchPresenter(delegate: self)
        self.searchPresenter?.findRecipes(text: "", page: pageNumber)

        self.searchBar.delegate = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.size.height - 20) && hasNextPage {
            if !self.isSearching {
                self.isSearching = true

                self.pageNumber += 1
                self.searchPresenter?.findRecipes(text: "", page: pageNumber)
            }
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

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return (recipes.count == 0) ? 1 : recipes.count
        case 1:
            return hasNextPage ? 1 : 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if recipes.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Error Cell") as! ErrorTableViewCell
                
                cell.configure(text: "Не найдено")
                
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Recipe Cell") as! SearchRecipeTableViewCell
            
            let recipe = self.recipes[indexPath.item]
            cell.configure(recipe: recipe)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Loading Cell") ?? UITableViewCell()
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("in didSelectRowAt")
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("in didDeselectRowAt")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.pageNumber = 1
        
        self.searchPresenter?.findRecipes(text: searchText, page: 1)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.becomeFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
}

extension SearchViewController: SearchDelegate {
    
    func setRecipes(searchResult: SearchResult) {
        self.recipes = searchResult.recipes
        print(self.recipes.count)
        self.hasNextPage = searchResult.hasNextPage
        
        self.tableView.reloadData()
    }
    
    func addRecipes(searchResult: SearchResult) {
        self.recipes += searchResult.recipes
        self.hasNextPage = searchResult.hasNextPage
        
        self.tableView.reloadData()
        isSearching = false
    }
    
    func endSearching() {
        self.isSearching = false
        self.hasNextPage = false
        self.tableView.reloadData()
    }
}
