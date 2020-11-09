//
//  DataBaseService.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 26.10.2020.
//

import Foundation

final class DataBaseService {
    static let shared = DataBaseService()
    
    private init() {
    }
    
    func addProducts(products: [Product]) -> ([Int], Error) {
        
    }
    
    func addProduct(products: Product) -> (Int, Error) {
        
    }
    
    func changeProduct(product: Product) -> Error {
        
    }
    
    func deleteProduct(id: Int) -> Error {
        
    }
}
