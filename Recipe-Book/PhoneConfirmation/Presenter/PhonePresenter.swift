//
//  PhonePresenter.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 17.10.2020.
//

import Foundation

protocol PhoneDelegate {
    func showProgress()
    func hideProgress()
    func phoneDidSucceed(phone: String)
    func phoneDidFailed(message: String)
    func showMessage(message: String)
}

class PhonePresenter {
    var delegate: PhoneDelegate
    var phone: String? = "123123123"
    var code: String? = "1111"

    init(delegate: PhoneDelegate) {
        self.delegate = delegate
    }
    
    func sendCode(phone: String) {
        if phone.isEmpty {
            self.delegate.phoneDidFailed(message: "Введите телефон")
            return
        }
        
        delegate.showProgress()
        PhoneNetworkService.sendCode(phone: phone) { [weak self] (response, statusCode) in
            self?.delegate.hideProgress()
            if response != nil && (200...299) ~= statusCode {
                self?.code = response
                self?.phone = phone
                self?.delegate.showMessage(message: "Код отправлен")
            } else {
                self?.delegate.phoneDidFailed(message: "Something wrong. \(statusCode)")
            }
        }
    }
    
    func confirmPhone(code: String) {
        if code.isEmpty {
            self.delegate.phoneDidFailed(message: "Введите код")
            return
        }
        
        if code == self.code {
            self.delegate.phoneDidSucceed(phone: phone ?? "")
        } else {
            self.delegate.phoneDidFailed(message: "Код не совпадает")
        }
    }
}
