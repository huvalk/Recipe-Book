//
//  DataBaseService.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 26.10.2020.
//

import Foundation
import RealmSwift

final class DataBaseService {
    static let shared = DataBaseService()
    let realm = try! Realm()
    
    private init() {
    }
}
