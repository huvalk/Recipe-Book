//
//  ProductRealm.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 09.11.2020.
//

import Foundation
import RealmSwift
 
class ProductRealm: Object {
    let id: Int
    let name: String
    var amountType: AmountType
    var amount: Double
    var bought: Bool
}
