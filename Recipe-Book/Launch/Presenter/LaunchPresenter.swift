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

class LaunchPresenter {
    var delegate: LaunchDelegate

    init(delegate: LaunchDelegate) {
        self.delegate = delegate
    }
    
    func authTry() {
        guard let user = SettingsService.userModel, let session = user.session else {
            delegate.launchDidFailed()
            return
        }
        
        LaunchNetworkService.checkSession(session: session) {statusCode in
            if (200...299) ~= statusCode {
                self.delegate.launchDidSucceed()
            } else {
                self.delegate.launchDidFailed()
            }
        }
    }
}
