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
        
        // TODO переделать на модель
        let parameters: RegisterUser = RegisterUser(login: user.login, password: user.password, phone: user.phone)
        
        var jsonData = Data()
        do {
            jsonData = try JSONEncoder().encode(parameters)
        } catch {
            print("json serialization error")
        }
        
        NetworkService.shared.postRequest(rawUrl: path, data: jsonData) { (responseData, statusCode) in
            do {
                completion(statusCode)
            } catch {
                print("Invalid login json")
            }
        }
    }
}
