//
//  Product.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 24.10.2020.
//

import Foundation

class Product: Ingredient {
    init(id: Int, name: String, amountType: Ingredient.AmountType, amount: Double, bought: Bool) {
        self.id = id
        super.init(name: name, amountType: amountType, amount: amount, bought: bought)
    }
    
    override init(name: String, amountType: Product.AmountType, amount: Double, bought: Bool) {
        self.id = ShoppingDatabaseService.productNextId
        super.init(name: name, amountType: amountType, amount: amount, bought: bought)
    }
    
    let id: Int
}
