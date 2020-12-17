//
//  CreationDataBaseService.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 17.12.2020.
//

import Foundation

class CreationDatabaseService {
    private init() {}
    
//    static var productNextId: Int {
//        get {
//            let curId = DataBaseService.shared.realm.objects(ProductRealm.self).max(ofProperty: "id") ?? 0
//             return curId + 1
//        }
//        set {
//            debugPrint("Cannot set nextId")
//        }
//    }
    
//    static func getRecipes() -> [Recipe] {
//        let result = DataBaseService.shared.realm.objects(ProductRealm.self)
//
//        var products: [Product] = []
//        for productRealm in result {
//            products.append(productRealm.toProduct())
//        }
//
//        return products
//    }
    
    static func saveRecipe(_ recipe: Recipe) -> Recipe? {
//        do {
//            try DataBaseService.shared.realm.write { () -> Void in
//                DataBaseService.shared.realm.add(ProductRealm.create(origin: product))
//            }
//
//            return product
//        } catch {
//            return nil
//        }
        return nil
    }
    
    static func saveRecipeInternal(_ recipe: Recipe) -> Recipe? {
//        do {
//            try DataBaseService.shared.realm.write { () -> Void in
//                DataBaseService.shared.realm.add(ProductRealm.create(origin: product))
//            }
//
//            return product
//        } catch {
//            return nil
//        }
        return nil
    }
}
