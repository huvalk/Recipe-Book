//
//  LaunchNetworkServices.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 18.10.2020.
//

import Foundation

class LaunchNetworkService {
    private init() {}
    
    static func checkSession(session: String, completion: @escaping(Int) -> ()) {
        let path = "/session"
        let parameters: [String: Any] = [
            "session": session
        ]
        
        NetworkService.shared.postRequest(rawUrl: path, data: parameters) { (json, statusCode)  in
            do {
                completion(statusCode)
            } catch {
                print("Invalid login json")
            }
        }
    }
}
