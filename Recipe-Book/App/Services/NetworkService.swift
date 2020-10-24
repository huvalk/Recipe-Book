//
//  NetworkService.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 15.10.2020.
//

import Foundation

class NetworkService {
    let host: String = "https://ios.hahao.ru/api"
    var currentUser: User?
    
    private init() {
        
    }
    
    static let shared = NetworkService()
    
    public func getRequest(rawUrl: String, completion: @escaping (Data, Int) -> ()) {
        let urlString = self.host + rawUrl
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                return
            }
            
            var statusCode: Int
            if let response = response as? HTTPURLResponse {
                statusCode = response.statusCode
            } else {
                statusCode = 600
            }
            
            DispatchQueue.main.async {
                completion(data, statusCode)
            }
            
        }.resume()
    }
    
    public func postRequest(rawUrl: String, data: Data, completion: @escaping (Data, Int) -> ()) {
        let urlString = self.host + rawUrl
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                return
            }
            
            var statusCode: Int
            if let response = response as? HTTPURLResponse {
                statusCode = response.statusCode
            } else {
                statusCode = 600
            }
            
            DispatchQueue.main.async {
                completion(data, statusCode)
            }
            
        }.resume()
    }
    
    public func login(rawUrl: String, data: Data, completion: @escaping (User?, Int) -> ()) {
        let urlString = self.host + rawUrl
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        self.postRequest(rawUrl: rawUrl, data: data) { (responseData, statusCode) in
            var newStatusCode = statusCode
            do {
                let user = try JSONDecoder().decode(User.self, from: responseData)
                SettingsService.userModel = user
            } catch {
                print("json error in login")
                newStatusCode += 1000
            }
            
            print(SettingsService.userModel)
            
            DispatchQueue.main.async {
                completion(SettingsService.userModel, statusCode)
            }
        }
    }
}
