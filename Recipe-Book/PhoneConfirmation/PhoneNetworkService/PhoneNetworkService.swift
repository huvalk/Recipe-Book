//
//  PhoneNetworkService.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 17.10.2020.
//

import Foundation

class PhoneNetworkService {
    private init() {}
    
    static func sendCode(phone: String, completion: @escaping(String?, Int) -> ()) {
        let path = "/phone/\(phone)/confirm"
        
        NetworkService.shared.getRequest(rawUrl: path) { (json, statusCode)  in
            do {
                guard let dict = json as? [String: AnyObject] else {
                    throw JSONErrors.marshalJSONError
                }
                
                completion(dict["code"] as? String, statusCode)
            } catch {
                print("Invalid login json")
            }
        }
    }
}
