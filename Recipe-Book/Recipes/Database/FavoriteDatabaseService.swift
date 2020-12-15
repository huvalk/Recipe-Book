//
//  FavoriteDatabaseService.swift
//  Recipe-Book
//
//  Created by User on 15.12.2020.
//

import Foundation

class FavoriteDatabaseService {
    
    static func getFavorites() -> [Recipe] {
        let result = DataBaseService.shared.realm.objects(FavoriteRealm.self)
        
        var recipes: [Recipe] = []
        for favorite in result {
            recipes.append(favorite.toRecipe())
        }
        
        return recipes
    }
    
    static func saveFavorite(_ recipe: Recipe) -> Recipe? {
        do {
            try DataBaseService.shared.realm.write { () -> Void in
                DataBaseService.shared.realm.add(FavoriteRealm.create(recipe: recipe))
            }
            
            return recipe
        } catch {
            return nil
        }
    }
    
    static func deleteFavorite(_ id: Int) -> Bool {
        do {
            try DataBaseService.shared.realm.write { () -> Void in
                let toDelete = DataBaseService.shared.realm.objects(FavoriteRealm.self).filter("id = %@", id)
                DataBaseService.shared.realm.delete(toDelete)
            }
            
            return true
        } catch {
            return false
        }
    }
    
    static func clearFavorites() -> Bool {
        do {
            try DataBaseService.shared.realm.write { () -> Void in
                let toDelete = DataBaseService.shared.realm.objects(FavoriteRealm.self)
                DataBaseService.shared.realm.delete(toDelete)
            }
            
            return true
        } catch {
            return false
        }
    }
}
