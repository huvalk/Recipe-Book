//
//  RegistrationPresenter.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 15.10.2020.
//

import Foundation

protocol RegistrationDelegate {
    func showProgress()
    func hideProgress()
    func registrationDidSucceed()
    func registrationDidFailed(message: String)
}

class RegistrationPresenter {
    var delegate: RegistrationDelegate
    var modelUser: RegisterUser
    
    init(delegate: RegistrationDelegate, model: RegisterUser) {
        self.delegate = delegate
        self.modelUser = model
    }
    
    init(delegate: RegistrationDelegate) {
        self.delegate = delegate
        self.modelUser = RegisterUser(login: "", password: "", phone: "")
    }
    
    func register(login: String, password: String, repeatPassword: String, phone: String) {
        if login.isEmpty || password.isEmpty || repeatPassword.isEmpty || phone.isEmpty {
            self.delegate.registrationDidFailed(message: "Логин или пароль не верны")
            return
        }
        if repeatPassword != password {
            self.delegate.registrationDidFailed(message: "Пароли не совпадают")
        }
        modelUser.login = login
        modelUser.password = password
        modelUser.phone = phone
        
        RegistrationNetworkService.regiter(user: modelUser) { (statusCode) in
            if (200...299) ~= statusCode {
                self.delegate.registrationDidSucceed()
            } else {
                self.delegate.registrationDidFailed(message: "Something wrong. \(statusCode)")
            }
        }
    }
    
}
