//
//  ShoppingViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 23.10.2020.
//

import UIKit

class ShoppingViewController: UIViewController {
    @IBOutlet weak var table: UITableView!

    private let transition = PanelTransition()
    private var presenter: ShoppingPresenter?
    private var productsToDisplay = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = ShoppingPresenter(delegate: self)
        table.separatorStyle = .none
        table.register(AddNewCell.self, forCellReuseIdentifier: "AddNewCell")
        
        setupNavigationController()
        table.dataSource = self
        table.delegate = self
        table.tableFooterView = UIView()
        table.allowsSelection = false
        presenter?.getProducts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.getProducts()
    }
    
    private func setupNavigationController() {
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
    }
    
    @IBAction func deleteBtnClicked(_ sender: Any) {
        self.productsToDisplay.removeAll()
        presenter?.clearProducts()
        
        UIView.transition(with: table, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.table.reloadData()
        }, completion: nil)
    }
    
    @IBAction func addBtnClicked(_ sender: Any) {
        let creatorViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductCreatorViewController") as! ProductCreatorViewController
        
        creatorViewController.transitioningDelegate = transition
        creatorViewController.modalPresentationStyle = .custom
        creatorViewController.dataTarget = self
        
        present(creatorViewController, animated: true)
    }
}

extension ShoppingViewController: ShoppingDelegate {
    func startLoad() {
        
    }
    
    func endLoad() {
        
    }
    
    func updateProducts(_ products: [Product]) {
        self.productsToDisplay = products
        UIView.transition(with: table, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.table.reloadData()
        }, completion: nil)
    }
    
    func clearProducts() {
        print("")
    }
}

extension ShoppingViewController: ShoppingCellDelegate {
    func didTapCheckBox(checked: Bool, index: IndexPath) {
        let oldProduct = self.productsToDisplay[index.row]
        oldProduct.bought = checked
        self.productsToDisplay[index.row] = oldProduct
        
        presenter?.changeProduct(oldProduct)
    }
    
    func didTapEdit(index: IndexPath) {
        let creatorViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductCreatorViewController") as! ProductCreatorViewController
        creatorViewController.setDefaultValue(ingredient: productsToDisplay[index.row], index: index)
        
        creatorViewController.transitioningDelegate = transition
        creatorViewController.modalPresentationStyle = .custom
        creatorViewController.dataTarget = self
        
        present(creatorViewController, animated: true)
    }
}

extension ShoppingViewController: DataTarget {
    func createFinished(ingredient: Ingredient) {
        let product = Product(ingredient: ingredient)
        self.productsToDisplay.append(product)
        presenter?.addProduct(product)
        UIView.transition(with: table, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.table.reloadData()
        }, completion: nil)
    }
    
    func editFinished(index: IndexPath, ingredient: Ingredient) {
        let oldProduct = self.productsToDisplay[index.row]
        let newProduct = Product(id: oldProduct.id, ingredient: ingredient)
        presenter?.changeProduct(newProduct)
        self.productsToDisplay[index.row] = newProduct
        table.reloadRows(at: [index], with: .top)
    }
}

extension ShoppingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return productsToDisplay.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = table.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ShoppingCell else {
                return UITableViewCell()
            }
            
            let prodactData = productsToDisplay[indexPath.row]
            cell.configure(data: prodactData, delegate: self)
            
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
            let product = self.productsToDisplay[indexPath.row]
            self.presenter?.deleteProduct(product)
            self.productsToDisplay.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = UIColor(named: "PastelDarkRed")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

extension ShoppingViewController: AddNewCellDelegate {
    func didTapAdd() {
        let mainView = UIStoryboard(name: "Main", bundle: nil)
        let creatorViewController = mainView.instantiateViewController(withIdentifier: "ProductCreatorViewController") as! ProductCreatorViewController
        
        creatorViewController.transitioningDelegate = transition
        creatorViewController.modalPresentationStyle = .custom
        creatorViewController.dataTarget = self
        
        present(creatorViewController, animated: true)
    }
}
