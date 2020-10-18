//
//  LaunchViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 18.10.2020.
//

import UIKit

class LaunchViewController: UIViewController {
    
    var launchPresenter: LaunchPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        launchPresenter = LaunchPresenter(delegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        launchPresenter?.authTry()
    }
}

extension LaunchViewController: LaunchDelegate {
    func showProgress() {
        print("show progress")
    }
    
    func hideProgress() {
        print("hide progress")
    }
    
    func launchDidSucceed() {
        // переход к главному экрану
//        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
//
//        self.present(mainViewController, animated: true)
    }
    
    func launchDidFailed() {
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        loginViewController.modalPresentationStyle = .fullScreen
        self.present(loginViewController, animated: true)
    }
}
