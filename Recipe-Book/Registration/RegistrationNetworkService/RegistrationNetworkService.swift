//
//  RegistrationNetworkService.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 16.10.2020.
//

import Foundation

class RegistrationNetworkService {
    private init() {}
    
    static func regiter(user: RegisterUser, completion: @escaping(Int) -> ()) {
        let path = "/users"
        
        let parameters: [String: Any] = [
            "login": user.login ?? "",
            "password": user.password ?? "",
            "phone": user.phone ?? ""
        ]
        
        NetworkService.shared.postRequest(rawUrl: path, data: parameters) { (response, statusCode) in
            do {
                completion(statusCode)
            } catch {
                print("Invalid login json")
            }
        }
    }
}
