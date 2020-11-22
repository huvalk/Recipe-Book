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
        
        NetworkService.shared.getRequest(rawUrl: path) { (responseData, statusCode)  in
            do {
                // TODO не возвращает код
                let sms = try JSONDecoder().decode(SmsCode.self, from: responseData)
                completion(sms.code, statusCode)
            } catch {
                print("Invalid login json")
            }
        }
    }
}
