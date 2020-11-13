//
//  ShoppingPresenter.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 24.10.2020.
//

import Foundation

class ShoppingPresenter {
    weak var delegate: ShoppingDelegate?
    
    init(delegate: ShoppingDelegate) {
        self.delegate = delegate
    }
    
    func getProducts() {
//        delegate?.startLoad()
        delegate?.updateProducts(ShoppingDatabaseService.getProducts())
    }
    
    func deleteProduct(_ product: Product) {
        _ = ShoppingDatabaseService.deleteProduct(product)
    }
    
    func clearProducts() {
        _ = ShoppingDatabaseService.clearProducts()
    }
    
    func changeProduct(_ product: Product) {
        _ = ShoppingDatabaseService.changeProduct(product)
    }
    
    func addProduct(_ product: Product) {
        _ = ShoppingDatabaseService.saveProduct(product)
    }
}

protocol ShoppingDelegate: NSObjectProtocol {
    func startLoad()
    func endLoad()
    func updateProducts(_ product: [Product])
    func clearProducts()
}
