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
        delegate?.updateProducts(products: [Product(id: 1, name: "Авакадо", amountType: Product.AmountType.count, amount: 2, bought: false), Product(id: 2, name: "Апельсин", amountType: Product.AmountType.gramm, amount: 550, bought: false), Product(id: 1, name: "Авакадо", amountType: Product.AmountType.count, amount: 2, bought: false), Product(id: 2, name: "Апельсин", amountType: Product.AmountType.gramm, amount: 550, bought: false), Product(id: 1, name: "Авакадо", amountType: Product.AmountType.count, amount: 2, bought: false), Product(id: 2, name: "Апельсин", amountType: Product.AmountType.gramm, amount: 550, bought: false), Product(id: 1, name: "Авакадо", amountType: Product.AmountType.count, amount: 2, bought: false), Product(id: 2, name: "Апельсин", amountType: Product.AmountType.gramm, amount: 550, bought: false), Product(id: 1, name: "Авакадо", amountType: Product.AmountType.count, amount: 2, bought: false), Product(id: 2, name: "Апельсин", amountType: Product.AmountType.gramm, amount: 550, bought: false), Product(id: 1, name: "Авакадо", amountType: Product.AmountType.count, amount: 2, bought: false), Product(id: 2, name: "Апельсин", amountType: Product.AmountType.gramm, amount: 550, bought: false)])
    }
}

protocol ShoppingDelegate: NSObjectProtocol {
    func startLoad()
    func endLoad()
    func updateProducts(products: [Product])
    func clearProducts()
}
