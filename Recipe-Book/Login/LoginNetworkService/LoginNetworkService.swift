//
//  LoginNetworkService.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 15.10.2020.
//

import Foundation

class LoginNetworkService {
    private init() {}
    
    static func login(user: LoginUser, completion: @escaping(User?) -> ()) {
        let path = "/login"
        
        let parameters: [String: Any] = [
            "login": user.login,
            "password": user.password
        ]
        
        NetworkService.shared.login(rawUrl: path, data: parameters) { (response) in
            do {
                completion(response)
            } catch {
                print("Invalid login json")
            }
        }
    }
    
    static func regiter(user: RegisterUser, completion: @escaping() -> ()) {
        let path = "/users"
        
        let parameters: [String: Any] = [
            "login": user.login,
            "password": user.password,
            "phone": user.phone
        ]
        
        NetworkService.shared.postRequest(rawUrl: path, data: parameters) { (response) in
            do {
                completion()
            } catch {
                print("Invalid login json")
            }
        }
    }
}
