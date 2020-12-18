//
//  MainCreationPresenter.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 17.12.2020.
//

import Foundation

class MainCreationPresenter {
    weak var delegate: MainCreationDelegate?
    
    init(delegate: MainCreationDelegate) {
        self.delegate = delegate
    }
    
    func saveRecipe(image: Data, name: String, timeToCook: Int, ingredients: [String], steps: [String]) {
        self.delegate?.startLoad()
        let b64Image = image.base64EncodedString()
        
        let user = SettingsService.userModel
        var recipe = Recipe(id: 0, author: user?.ID ?? -1, title: name, cookingTime: timeToCook, rating: 0, ingredients: ingredients, steps: steps, isFavorites: false, photo: b64Image)
        
        if user != nil  {
            CreationNetworkService.saveRecipe(recipe) {
                [weak self] savedRecipe, statusCode in
                guard let selfPointer = self else {
                    fatalError("No self to finish")
                }
                guard let delegatePointer = selfPointer.delegate else {
                    fatalError("No delegate to finish")
                }
            
                delegatePointer.endLoad()
                if statusCode == 201, let savedRecipe = savedRecipe {
                    recipe.id = savedRecipe.id
                    recipe.photo = savedRecipe.photo
    
                    delegatePointer.loadSucceed()
                } else {
                    recipe.id = -1
                    recipe.photo = selfPointer.saveImageLocal(image: image, photoName: name)
                    
                    delegatePointer.loadFailed()
                }
                let internalRecipe = MyRecipeRealm.create(recipe: recipe)
                internalRecipe.realmId = CreationDatabaseService.localRecipesNextId
                CreationDatabaseService.saveRecipeInternal(internalRecipe)
            }
        } else {
            self.delegate?.loadFailed()
            recipe.id = -1
            recipe.photo = saveImageLocal(image: image, photoName: name)
            let internalRecipe = MyRecipeRealm.create(recipe: recipe)
            internalRecipe.realmId = CreationDatabaseService.localRecipesNextId
            CreationDatabaseService.saveRecipeInternal(internalRecipe)
        }
    }
    
    fileprivate func saveImageLocal(image: Data, photoName: String) -> String {
        let timestamp = NSDate().timeIntervalSince1970
        let filename = photoName + "-\(timestamp).png"
        let filePath = getDocumentsDirectory().appendingPathComponent(filename)
        
        do {
            try image.write(to: filePath)
            return filename
        } catch {
            return "default"
        }
    }
    
    fileprivate func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

protocol MainCreationDelegate: NSObjectProtocol {
    func startLoad()
    func endLoad()
    func loadSucceed()
    func loadFailed()
}
