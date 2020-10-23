//
//  LaunchPresenter.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 18.10.2020.
//

import Foundation

protocol LaunchDelegate {
    func showProgress()
    func hideProgress()
    func launchDidSucceed()
    func launchDidFailed()
}
// Protocols
// LaunchViewOutput - LaunchPresenter
// LaunchViewInput - LaunchViewController
class LaunchPresenter {
    var delegate: LaunchDelegate

    init(delegate: LaunchDelegate) {
        self.delegate = delegate
    }
    
    func authTry() {
        guard let user = SettingsService.userModel else {
            delegate.launchDidFailed()
            return
        }
        
        LaunchNetworkService.checkSession(session: user.session) {statusCode in
            if (200...299) ~= statusCode {
                self.delegate.launchDidSucceed()
            } else {
                self.delegate.launchDidFailed()
            }
        }
    }
}
