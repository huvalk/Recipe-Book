//
//  FavoriteDatabaseService.swift
//  Recipe-Book
//
//  Created by User on 15.12.2020.
//

import Foundation

class MyRecipeDatabaseService {
    
    static func getMyRecipes() -> [Recipe] {
        let result = DataBaseService.shared.realm.objects(MyRecipeRealm.self)
        
        var recipes: [Recipe] = []
        for myRecipe in result {
            recipes.append(myRecipe.toRecipe())
        }
        
        return recipes
    }
    
    static func saveMyRecipe(_ recipe: Recipe) -> Recipe? {
        do {
            try DataBaseService.shared.realm.write { () -> Void in
                DataBaseService.shared.realm.add(MyRecipeRealm.create(recipe: recipe))
            }
            
            return recipe
        } catch {
            return nil
        }
    }
    
    static func deleteMyRecipe(_ id: Int) -> Bool {
        do {
            try DataBaseService.shared.realm.write { () -> Void in
                let toDelete = DataBaseService.shared.realm.objects(MyRecipeRealm.self).filter("id = %@", id)
                DataBaseService.shared.realm.delete(toDelete)
            }
            
            return true
        } catch {
            return false
        }
    }
    
    static func clearMyRecipes() -> Bool {
        do {
            try DataBaseService.shared.realm.write { () -> Void in
                let toDelete = DataBaseService.shared.realm.objects(MyRecipeRealm.self)
                DataBaseService.shared.realm.delete(toDelete)
            }
            
            return true
        } catch {
            return false
        }
    }
}
