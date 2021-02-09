//
//  LaunchPresenter.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 18.10.2020.
//

import Foundation

protocol LaunchDelegate: class {
    func showProgress()
    func hideProgress()
    func launchDidSucceed()
    func launchDidFailed()
}
// Protocols
// LaunchViewOutput - LaunchPresenter
// LaunchViewInput - LaunchViewController
class LaunchPresenter {
    weak var delegate: LaunchDelegate?

    init(delegate: LaunchDelegate) {
        self.delegate = delegate
    }
    
    func authTry() {
        guard let user = SettingsService.userModel else {
            self.delegate?.launchDidFailed()
            return
        }
        
        LaunchNetworkService.checkSession(session: user.session) {
            [weak self] statusCode in
            guard let selfPointer = self else {
                fatalError("No self to finish")
            }
            guard let delegatePointer = selfPointer.delegate else {
                fatalError("No delegate to finish")
            }
            
            if (200...299) ~= statusCode || statusCode == -1000 {
                delegatePointer.launchDidSucceed()
            } else {
                delegatePointer.launchDidFailed()
            }
        }
    }
}
