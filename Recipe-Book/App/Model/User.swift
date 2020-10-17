//
//  User.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.10.2020.
//

import Foundation

class User: NSObject, NSCoding {
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(login, forKey: "login")
        coder.encode(sessionID, forKey: "sessionID")
        coder.encode(phone, forKey: "phone")
    }
    
    required init?(coder: NSCoder) {
        id = coder.decodeObject(forKey: "id") as? Int
        login = coder.decodeObject(forKey: "login") as? String
        sessionID = coder.decodeObject(forKey: "sessionID") as? String
        phone = coder.decodeObject(forKey: "phone") as? String
    }
    
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
