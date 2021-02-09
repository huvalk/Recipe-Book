//
//  DatabaseService.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 10.11.2020.
//

import Foundation

class ShoppingDatabaseService {
    private init() {}
    
    static var productNextId: Int {
        get {
            let curId = DataBaseService.shared.realm.objects(ProductRealm.self).max(ofProperty: "id") ?? 0
             return curId + 1
        }
        set {
            debugPrint("Cannot set nextId")
        }
    }
    
    static func getProducts() -> [Product] {
        let result = DataBaseService.shared.realm.objects(ProductRealm.self)
        
        var products: [Product] = []
        for productRealm in result {
            products.append(productRealm.toProduct())
        }
        
        return products
    }
    
    static func saveProduct(_ product: Product) -> Product? {
        do {
            try DataBaseService.shared.realm.write { () -> Void in
                DataBaseService.shared.realm.add(ProductRealm.create(origin: product))
            }
            
            return product
        } catch {
            return nil
        }
    }
    
    static func changeProduct(_ product: Product) -> Product? {
        do {
            try DataBaseService.shared.realm.write { () -> Void in
                DataBaseService.shared.realm.add(ProductRealm.create(origin: product), update: .all)
            }
            
            return product
        } catch {
            return nil
        }
    }
    
    static func deleteProduct(_ product: Product) -> Bool {
        do {
            try DataBaseService.shared.realm.write { () -> Void in
                let objectToDelete = DataBaseService.shared.realm.objects(ProductRealm.self).filter("id = %@", product.id)
                DataBaseService.shared.realm.delete(objectToDelete)
            }
            
            return true
        } catch {
            return false
        }
    }
    
    static func clearProducts() -> Bool {
        do {
            try DataBaseService.shared.realm.write { () -> Void in
                let productsToDelete = DataBaseService.shared.realm.objects(ProductRealm.self)
                DataBaseService.shared.realm.delete(productsToDelete)
            }
            
            return true
        } catch {
            return false
        }
    }
}
