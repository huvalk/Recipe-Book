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
        
        var data = Data()
        do {
            data = try JSONEncoder().encode(user)
        } catch {
            print("json serialization error")
            return
        }
        
        NetworkService.shared.login(rawUrl: path, data: data) { (response, statusCode)  in
            do {
                NetworkService.shared.uploadLocalRecipes()
                completion(response, statusCode)
            } catch {
                print("Invalid login json")
            }
        }
    }
}
