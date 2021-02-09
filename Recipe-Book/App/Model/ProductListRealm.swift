//
//  ProductListRealm.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 09.11.2020.
//

import Foundation
import RealmSwift

class ProductListRealm: Object {
    let tasks = List<ProductRealm>()
}
