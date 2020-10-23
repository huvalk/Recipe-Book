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
        let parameters: Session = Session(session: session)
        
        var jsonData = Data()
        do {
            jsonData = try JSONEncoder().encode(parameters)
        } catch {
            print("json serialization error")
        }
        
        NetworkService.shared.postRequest(rawUrl: path, data: jsonData) { (json, statusCode)  in
            do {
                completion(statusCode)
            } catch {
                print("Invalid login json")
            }
        }
    }
}
