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
    
    public func getRequest(rawUrl: String, completion: @escaping (Any, Int) -> ()) {
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
            
            var json: Any = 0
            do {
                json = try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                statusCode = 600
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                completion(json, statusCode)
            }
            
        }.resume()
    }
    
    public func postRequest(rawUrl: String, data: [String: Any], completion: @escaping (Any, Int) -> ()) {
        let urlString = self.host + rawUrl
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            request.httpBody = jsonData
        } catch {
            print("JSON serialization error")
            return
        }
        
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
            
            var json: Any = 0
            do {
                json = try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                statusCode = 600
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                completion(json, statusCode)
            }
            
        }.resume()
    }
    
    public func login(rawUrl: String, data: [String: Any], completion: @escaping (User?, Int) -> ()) {
        let urlString = self.host + rawUrl
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            request.httpBody = jsonData
        } catch {
            print("JSON serialization error")
            return
        }
        
        //TODO Доделать запросо на логин
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
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                SettingsService.userModel = try User(json: json)
            } catch {
                statusCode = 600
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                completion(SettingsService.userModel, statusCode)
            }
            
            }.resume()
    
    }
}
