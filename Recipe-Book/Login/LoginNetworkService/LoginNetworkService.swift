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
            debugPrint("json serialization error")
            return
        }
        
        NetworkService.shared.login(rawUrl: path, data: data) { (response, statusCode)  in
            do {
                NetworkService.shared.uploadLocalRecipes()
                completion(response, statusCode)
            } catch {
                debugPrint("Invalid login json")
            }
        }
    }
    
    static func forgotPassword(user: LoginUser, completion: @escaping(Int) -> ()) {
        let path = "/login/restore"
        
        var data = Data()
        do {
            data = try JSONEncoder().encode(user)
        } catch {
            debugPrint("json serialization error")
            return
        }
        
        NetworkService.shared.postRequest(rawUrl: path, data: data) { (response, statusCode)  in
            do {
                completion(statusCode)
            } catch {
                debugPrint("Invalid login json")
            }
        }
    }
}
