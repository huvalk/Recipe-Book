//
//  LoginPresenter.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.10.2020.
//

import Foundation

protocol LoginDelegate {
    func showProgress()
    func hideProgress()
    func loginDidSucceed()
    func loginDidFailed(message: String)
}

class LoginPresenter {
    var delegate: LoginDelegate
    var modelUser: User
    
    init(delegate: LoginDelegate, model: User) {
        self.delegate = delegate
        self.modelUser = model
    }
    
    init(delegate: LoginDelegate) {
        self.delegate = delegate
        self.modelUser = User(login: "", password: "", sessionID: "", phone: "")
    }
    
    func login(login: String, password: String) {
        if login.isEmpty || password.isEmpty {
            self.delegate.loginDidFailed(message: "Логин или пароль не верны")
            return
        }
        
        if self.loginNetwork(login: login, password: password) {
            self.delegate.loginDidFailed(message: "Вход")
        } else {
            self.delegate.loginDidFailed(message: "Логин или пароль не верны")
        }
    }
    
    //TODO возвращать ошибку от логина
    func loginNetwork(login: String, password: String) -> Bool {
        let urlString = "https://ios.hahao.ru/api/login"
        guard let url = URL(string: urlString) else { return false }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = [
            "login": login,
            "password": password
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonData
        } catch {
            print("JSON serialization error")
            return false
        }
        
        //TODO Доделать запросо на логин
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            
            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                self.parsePosts(from: json)
            } catch {
                print(error.localizedDescription)
            }
            
            }.resume()
        
        return true
    }
    
}
