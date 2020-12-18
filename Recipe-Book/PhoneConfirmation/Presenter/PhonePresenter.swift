//
//  PhonePresenter.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 17.10.2020.
//

import Foundation

protocol PhoneDelegate: class {
    func showProgress()
    func hideProgress()
    func phoneDidSucceed(phone: String)
    func phoneDidFailed(message: String)
    func showMessage(message: String)
}

class PhonePresenter {
    weak var delegate: PhoneDelegate?
    var phone: String? = "123123123"
    var code: String? = "1111"

    init(delegate: PhoneDelegate) {
        self.delegate = delegate
    }
    
    func sendCode(phone: String) {
        if phone.isEmpty {
            self.delegate?.phoneDidFailed(message: "Введите телефон")
            return
        }
        
        delegate?.showProgress()
        PhoneNetworkService.sendCode(phone: phone) {
            [weak self] (response, statusCode) in
            guard let selfPointer = self else {
                fatalError("No self to finish")
            }
            guard let delegatePointer = selfPointer.delegate else {
                fatalError("No delegate to finish")
            }
            
            
            delegatePointer.hideProgress()
            if response != nil && (200...299) ~= statusCode {
                selfPointer.code = response
                selfPointer.phone = phone
                delegatePointer.showMessage(message: "Код отправлен")
            } else {
                delegatePointer.phoneDidFailed(message: "Something wrong. \(statusCode)")
            }
        }
    }
    
    func confirmPhone(code: String) {
        if code.isEmpty {
            self.delegate?.phoneDidFailed(message: "Введите код")
            return
        }
        
        if code == self.code {
            self.delegate?.phoneDidSucceed(phone: phone ?? "")
        } else {
            self.delegate?.phoneDidFailed(message: "Код не совпадает")
        }
    }
}
