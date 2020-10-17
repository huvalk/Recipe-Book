//
//  LoginNetworkService.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 15.10.2020.
//

import Foundation

class LoginNetworkService {
    private init() {}
    
    static func login(user: LoginUser, completion: @escaping(User?, Int) -> ()) {
        let path = "/login"
        
        let parameters: [String: Any] = [
            "login": user.login ?? "",
            "password": user.password ?? ""
        ]
        
        NetworkService.shared.login(rawUrl: path, data: parameters) { (response, statusCode)  in
            do {
                completion(response, statusCode)
            } catch {
                print("Invalid login json")
            }
        }
    }
}
