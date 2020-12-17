//
//  Product.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 24.10.2020.
//

import Foundation

class Ingredient {
    enum AmountType: Int {
        case count = 0
        case gramm
        case kgramm
        case litr
        case mlitr
        
        static let mapper: [AmountType: String] = [
            .count: "шт.",
            .gramm: "гр.",
            .kgramm: "кг.",
            .litr: "л.",
            .mlitr: "мл."
        ]
        var string: String {
            return AmountType.mapper[self]!
        }
        static let length = 5
    }
    
    init(name: String, amountType: Ingredient.AmountType, amount: Double, bought: Bool) {
        self.name = name
        self.amountType = amountType
        self.amount = amount
        self.bought = bought
    }
    
    let name: String
    var amountType: AmountType
    var amount: Double
    var bought: Bool
}
