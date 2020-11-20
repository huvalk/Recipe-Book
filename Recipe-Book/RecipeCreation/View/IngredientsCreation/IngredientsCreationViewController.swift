//
//  IngredientsCreationViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.11.2020.
//

import UIKit

class IngredientsCreationViewController: UIViewController {
    private let tableView = UITableView()
    private var ingredients = [Ingredient]()
    
    private let transition = PanelTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        self.view.backgroundColor = .orange
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(IngredientCell.self, forCellReuseIdentifier: "IngredientCell")
        tableView.register(AddNewCell.self, forCellReuseIdentifier: "AddNewCell")
        tableView.allowsSelection = false
        
        view.addSubview(tableView)
        self.tableView.pin
            .top()
            .bottom()
            .left()
            .right()
        
        tableView.frame = view.frame
    }
}

extension IngredientsCreationViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return ingredients.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientCell
            let ingredientData = self.ingredients[indexPath.row]
            
            cell.configure(number: indexPath.row + 1, ingredient: ingredientData, table: self)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddNewCell", for: indexPath) as! AddNewCell
            cell.addDelegate = self
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            self.ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = UIColor(named: "PastelDarkRed")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func getData() -> [Ingredient] {
        return ingredients
    }
}

extension IngredientsCreationViewController: AddNewCellDelegate {
    func didTapAdd() {
        let mainView = UIStoryboard(name: "Main", bundle: nil)
        let creatorViewController = mainView.instantiateViewController(withIdentifier: "ProductCreatorViewController") as! ProductCreatorViewController
        
        creatorViewController.transitioningDelegate = transition
        creatorViewController.modalPresentationStyle = .custom
        creatorViewController.dataTarget = self
        
        present(creatorViewController, animated: true)
    }
}

extension IngredientsCreationViewController: InredientCellDelegate {
    func didTapEdit(index: IndexPath) {
        let mainView = UIStoryboard(name: "Main", bundle: nil)
        let creatorViewController = mainView.instantiateViewController(withIdentifier: "ProductCreatorViewController") as! ProductCreatorViewController
        creatorViewController.setDefaultValue(ingredient: ingredients[index.row], index: index)
        
        creatorViewController.transitioningDelegate = transition
        creatorViewController.modalPresentationStyle = .custom
        creatorViewController.dataTarget = self
        
        present(creatorViewController, animated: true)
    }
}

extension IngredientsCreationViewController: DataTarget {
    func createFinished(ingredient: Ingredient) {
        self.ingredients.append(ingredient)
        tableView.reloadData()
    }
    
    func editFinished(index: IndexPath, ingredient: Ingredient) {
        self.ingredients[index.row] = ingredient
        tableView.reloadRows(at: [index], with: .top)
    }
}
