//
//  NetworkService.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 15.10.2020.
//

import Foundation

final class NetworkService {
    let host: String = "https://ios.hahao.ru/api"
    var currentUser: User?
    
    private init() {
        
    }
    
    static let shared = NetworkService()
    
    public func uploadLocalRecipes() {
        let recipes = CreationDatabaseService.getUnsavedRecipes()
        let currentPath = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
        DispatchQueue.global(qos: .background).async {
            recipes.forEach() { (realmId, recipe) in
                var recipeCopy = recipe
                var image: Data
                do {
                    let url = URL(fileURLWithPath: recipeCopy.photo, relativeTo: currentPath)
                    image = try Data(contentsOf: url)
                } catch {
                    debugPrint(error)
                    return
                }
                
                recipeCopy.photo = image.base64EncodedString()
                CreationNetworkService.saveRecipe(recipeCopy) {
                    savedRecipe, statusCode in
                
                    if statusCode == 201, let savedRecipe = savedRecipe {
                        DispatchQueue.main.async {
                            _ = CreationDatabaseService.updateRecipeInfo(realmId: realmId, id: savedRecipe.id, author: savedRecipe.author, photoUrl: savedRecipe.photo)
                        }
                    }
                }
            }
        }
    }
    
    public func getRequest(rawUrl: String, completion: @escaping (Data, Int) -> ()) {
        let urlString = self.host + rawUrl
        guard let url = URL(string: urlString) else { return }
        
        if let user = SettingsService.userModel {
            let session_id = user.session
            let cookieHeaderField = ["Set-Cookie": "session_id=\(session_id)"]
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: cookieHeaderField, for: url)
            HTTPCookieStorage.shared.setCookies(cookies, for: url, mainDocumentURL: url)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(Data(), -1000)
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(Data(), -1000)
                }
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
        
        if let user = SettingsService.userModel {
            let session_id = user.session
            let cookieHeaderField = ["Set-Cookie": "session_id=\(session_id)"]
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: cookieHeaderField, for: url)
            HTTPCookieStorage.shared.setCookies(cookies, for: url, mainDocumentURL: url)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(Data(), -1000)
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(Data(), -1000)
                }
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
                debugPrint("json error in login")
                newStatusCode += 1000
            }
            
            DispatchQueue.main.async {
                completion(SettingsService.userModel, newStatusCode)
            }
        }
    }
}
