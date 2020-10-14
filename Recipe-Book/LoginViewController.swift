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
    }
    
    private func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWasShown(notification: Notification) {
        loginLabel.isHidden = true
        guard let info = notification.userInfo else {
            shiftConstraint.constant = -100
            return
        }
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let constant = -(keyboardSize?.height ?? 100) * 2 / 3
        
        animateShift(pos: constant, alpha: 0)
    }
    
    @objc private func keyboardWillBeHidden(notification: Notification) {
        loginLabel.isHidden = false
        
        animateShift(pos: 0, alpha: 1)
    }
    
    private func animateShift(pos: CGFloat, alpha: CGFloat) {
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveLinear, animations: {
            self.loginLabel.alpha = alpha
            self.shiftConstraint.constant = pos
            self.view.layoutIfNeeded()
          }, completion: { finished in
            print("Animation completed")
          })
    }
    
    deinit {
        unregisterForKeyboardNotifications()
    }
}
