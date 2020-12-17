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
    
    func saveRecipe(_ recipe: Recipe) {
        CreationNetworkService.saveRecipe(recipe) {
            [weak self] savedRecipe, statusCode in
            guard let selfPointer = self?.delegate else {
                fatalError("No delegate to finish")
            }
        
            selfPointer.endLoad()
            if statusCode == 201, let savedRecipe = savedRecipe {
                CreationDatabaseService.saveRecipe(savedRecipe)
                selfPointer.loadSucceed()
            } else {
                CreationDatabaseService.saveRecipeInternal(recipe)
                selfPointer.loadFailed()
            }
        }
    }
}

protocol MainCreationDelegate: NSObjectProtocol {
    func startLoad()
    func endLoad()
    func loadSucceed()
    func loadFailed()
}
