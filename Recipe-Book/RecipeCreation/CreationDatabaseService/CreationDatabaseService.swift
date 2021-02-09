//
//  CreationDataBaseService.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 17.12.2020.
//

import Foundation

class CreationDatabaseService {
    private init() {}
    
    static var localRecipesNextId: Int {
        get {
            let curId = DataBaseService.shared.realm.objects(MyRecipeRealm.self).max(ofProperty: "realmId") ?? 0
             return curId + 1
        }
        set {
            debugPrint("Cannot set nextId")
        }
    }
    
    static func getUnsavedRecipes() -> [Int:Recipe] {
        let result = DataBaseService.shared.realm.objects(MyRecipeRealm.self)
            .filter("id = %@", -1)

        var recipes: [Int:Recipe] = [:]
        for recipeRealm in result {
            var normalRecipe = recipeRealm.toRecipe()
            normalRecipe.id = 0
            normalRecipe.author = 0
            recipes[recipeRealm.realmId] = normalRecipe
        }
        
        return recipes
    }
    
    static func updateRecipeInfo(realmId: Int, id: Int, author: Int, photoUrl: String) -> Bool {
        let result = DataBaseService.shared.realm.objects(MyRecipeRealm.self)
            .filter("realmId = %@", realmId)

        do {
            guard let recipe = result.first else {
                return true
            }
            try DataBaseService.shared.realm.write { () -> Void in
                recipe.id = id
                recipe.author = author
                recipe.photo = photoUrl
            }
            
            return true
        } catch {
            return false
        }
    }
    
    static func saveRecipeInternal(_ recipe: MyRecipeRealm) -> MyRecipeRealm? {
        do {
            try DataBaseService.shared.realm.write { () -> Void in
                DataBaseService.shared.realm.add(recipe)
            }

            return recipe
        } catch {
            return nil
        }
        return nil
    }
}
