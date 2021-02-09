//
//  ProductRealm.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 09.11.2020.
//

import Foundation
import RealmSwift
 
class ProductRealm: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var amountType: Int = 0
    @objc dynamic var amount: Double = 0
    @objc dynamic var bought: Bool = false
    
    static func create(origin: Product) -> ProductRealm {
        let inst = ProductRealm()
        inst.id = origin.id
        inst.name = origin.name
        inst.amountType = origin.amountType.rawValue
        inst.amount = origin.amount
        inst.bought = origin.bought
        
        return inst
    }
    
    func toProduct() -> Product {
        return Product(id: self.id, name: self.name, amountType: Product.AmountType(rawValue: self.amountType) ?? Product.AmountType.gramm, amount: self.amount, bought: self.bought)
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
