//
//  User.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.10.2020.
//

import Foundation

struct User {
    let id: Int?
    let login: String?
    let sessionID: String?
    let phone: String?
    
    init?(dict: [String: AnyObject]) {
        self.id = dict["id"] as? Int
        self.login = dict["login"] as? String
        self.sessionID = dict["sessionID"] as? String
        self.phone = dict["phone"] as? String
    }
    
    init?(json: Any) throws {
        guard let dict = json as? [String: AnyObject] else {
            throw JSONErrors.marshalJSONError
        }
        
        self.id = dict["id"] as? Int
        self.login = dict["login"] as? String
        self.sessionID = dict["sessionID"] as? String
        self.phone = dict["phone"] as? String
    }
}
