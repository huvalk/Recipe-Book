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
    
    public func getRequest(rawUrl: String, completion: @escaping (Any) -> ()) {
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
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                print(error)
            }
        }.resume()
    }
    
    public func postRequest(rawUrl: String, data: [String: Any], completion: @escaping (Any) -> ()) {
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
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                DispatchQueue.main.async {
                    completion(json)
                }
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    public func login(rawUrl: String, data: [String: Any], completion: @escaping (User?) -> ()) {
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
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                self.currentUser = try User(json: json)
                
                DispatchQueue.main.async {
                    completion(self.currentUser)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil)
                }
                print(error.localizedDescription)
            }
            
            }.resume()
    
    }
}
