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
        
        table.dataSource = self
        table.delegate = self
        table.tableFooterView = UIView()
        presenter?.getProducts()
    }
}

extension ShoppingViewController: ShoppingDelegate {
    func startLoad() {
        
    }
    
    func endLoad() {
        
    }
    
    func updateProducts(products: [Product]) {
        self.productsToDisplay = products
        table.reloadData()
    }
    
    func clearProducts() {
        print("")
    }
}

extension ShoppingViewController: ShoppingCellDelegate {
    func didTapEdit(index: IndexPath) {
//        let creatorViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductCreatorViewController") as! ProductCreatorViewController
//        creatorViewController.setDefaultValue(product: productsToDisplay[index.row], index: index)
//
//        creatorViewController.target = self
//        self.present(creatorViewController, animated: true)
        let creatorViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductCreatorViewController") as! ProductCreatorViewController
        creatorViewController.setDefaultValue(product: productsToDisplay[index.row], index: index)
        
        creatorViewController.transitioningDelegate = transition
        creatorViewController.modalPresentationStyle = .custom
        creatorViewController.target = self
        
        present(creatorViewController, animated: true)
    }
}

extension ShoppingViewController: DataTarget {
    func editFinished(row: Int, product: Product) {
        self.productsToDisplay[row] = product
        table.reloadData()
    }
}

extension ShoppingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ShoppingCell else {
            return UITableViewCell()
        }
        
        let prodactData = productsToDisplay[indexPath.row]
        cell.configure(data: prodactData, delegate: self)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            print("insert \(indexPath.row)")
        }
    }
    
}
