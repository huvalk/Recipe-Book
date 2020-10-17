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
    var modelUser: LoginUser
    
    init(delegate: LoginDelegate, model: LoginUser) {
        self.delegate = delegate
        self.modelUser = model
    }
    
    init(delegate: LoginDelegate) {
        self.delegate = delegate
        self.modelUser = LoginUser(login: "", password: "", sessionID: "")
    }
    
    func login(login: String, password: String) {
        if login.isEmpty || password.isEmpty {
            self.delegate.loginDidFailed(message: "Логин или пароль не верны")
            return
        }
        modelUser.login = login
        modelUser.password = password
        
        LoginNetworkService.login(user: modelUser) { (response, statusCode) in
            if response != nil && (200...299) ~= statusCode {
                self.delegate.loginDidSucceed()
            } else {
                self.delegate.loginDidFailed(message: "Something wrong. \(statusCode)")
            }
        }
    }
}
