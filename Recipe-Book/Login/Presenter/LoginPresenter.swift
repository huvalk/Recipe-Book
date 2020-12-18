//
//  LoginPresenter.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.10.2020.
//

import Foundation

protocol LoginDelegate: class {
    func showProgress()
    func hideProgress()
    func loginDidSucceed()
    func loginDidFailed(message: String)
}

class LoginPresenter {
    weak var delegate: LoginDelegate?
    var modelUser: LoginUser
    
    init(delegate: LoginDelegate, model: LoginUser) {
        self.delegate = delegate
        self.modelUser = model
    }
    
    init(delegate: LoginDelegate) {
        self.delegate = delegate
        self.modelUser = LoginUser(login: "", password: "")
    }
    
    func login(login: String, password: String) {
        if login.isEmpty || password.isEmpty {
            self.delegate?.loginDidFailed(message: "Логин или пароль не верны")
            return
        }
        modelUser.login = login
        modelUser.password = password
        
        delegate?.showProgress()
        LoginNetworkService.login(user: modelUser) {
            [weak self] (response, statusCode) in
            guard let selfPointer = self else {
                fatalError("No self to finish")
            }
            guard let delegatePointer = selfPointer.delegate else {
                fatalError("No delegate to finish")
            }
            
            delegatePointer.hideProgress()
            if response != nil && (200...299) ~= statusCode {
                delegatePointer.loginDidSucceed()
            } else {
                delegatePointer.loginDidFailed(message: "Something wrong. \(statusCode)")
            }
        }
    }
}
