//
//  User.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.10.2020.
//

import Foundation

class User: NSObject, Codable, NSCoding {
    func encode(with coder: NSCoder) {
        coder.encode("\(ID)", forKey: "ID")
        coder.encode(login, forKey: "login")
        coder.encode(session, forKey: "session")
        coder.encode(phone, forKey: "phone")
    }
    
    required init?(coder: NSCoder) {
        let stringId = coder.decodeObject(forKey: "ID") as? String ?? "0"
        ID = Int(stringId) ?? 0
        login = coder.decodeObject(forKey: "login") as? String ?? ""
        session = coder.decodeObject(forKey: "session") as? String ?? ""
        phone = coder.decodeObject(forKey: "phone") as? String ?? ""
    }
    
    let ID: Int
    let login: String
    let session: String
    let phone: String
}
