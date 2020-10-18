//
//  User.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.10.2020.
//

import Foundation

class User: NSObject, NSCoding {
    func encode(with coder: NSCoder) {
        coder.encode(ID, forKey: "ID")
        coder.encode(login, forKey: "login")
        coder.encode(session, forKey: "session")
        coder.encode(phone, forKey: "phone")
    }
    
    required init?(coder: NSCoder) {
        ID = coder.decodeObject(forKey: "ID") as? Int
        login = coder.decodeObject(forKey: "login") as? String
        session = coder.decodeObject(forKey: "session") as? String
        phone = coder.decodeObject(forKey: "phone") as? String
    }
    
    let ID: Int?
    let login: String?
    let session: String?
    let phone: String?
    
    init?(dict: [String: AnyObject]) {
        self.ID = dict["ID"] as? Int
        self.login = dict["login"] as? String
        self.session = dict["session"] as? String
        self.phone = dict["phone"] as? String
    }
    
    init?(json: Any) throws {
        guard let dict = json as? [String: AnyObject] else {
            throw JSONErrors.marshalJSONError
        }
        
        self.ID = dict["ID"] as? Int
        self.login = dict["login"] as? String
        self.session = dict["session"] as? String
        self.phone = dict["phone"] as? String
    }
}
