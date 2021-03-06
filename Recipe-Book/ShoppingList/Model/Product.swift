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
    
    init(ingredient: Ingredient) {
        self.id = ShoppingDatabaseService.productNextId
        super.init(name: ingredient.name, amountType: ingredient.amountType, amount: ingredient.amount, bought: ingredient.bought)
    }
    
    init(id: Int, ingredient: Ingredient) {
        self.id = id
        super.init(name: ingredient.name, amountType: ingredient.amountType, amount: ingredient.amount, bought: ingredient.bought)
    }
    
    let id: Int
}
