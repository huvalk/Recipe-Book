//
//  LoginViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.10.2020.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var shiftConstraint: NSLayoutConstraint!
    @IBOutlet weak var spaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputContainer: UIView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var lostPswdButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initScreen()
        
        registerForKeyboardNotifications()
    }
    
    private func initScreen() {
        loginButton.layer.cornerRadius = 15
    }
    
    private func registerForKeyboardNotifications() {
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)

    }
    
    @objc private func keyboardWasShown(notification: Notification) {
        loginLabel.isHidden = true
        guard let info = notification.userInfo else {
            shiftConstraint.constant = -100
            return
        }
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        shiftConstraint.constant = -(keyboardSize?.height ?? 100) / 2
    }
    
    @objc private func keyboardWillBeHidden(notification: Notification) {
        loginLabel.isHidden = false
        shiftConstraint.constant = 0
    }
    
    @objc private func rotated(notification: NSNotification) {
        if UIDevice.current.orientation.isLandscape {
            spaceConstraint.constant = 25
        } else {
            spaceConstraint.constant = 60
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
