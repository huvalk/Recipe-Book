//
//  RegistrationViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 15.10.2020.
//

import UIKit

class RegistrationViewController: UIViewController {
    @IBOutlet weak var registrationLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    var phone: String?
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var shiftContainer: NSLayoutConstraint!
    @IBOutlet weak var registerButton: UIButton!
    let spinner = UIActivityIndicatorView(style: .large)
    
    var registrationPresenter: RegistrationPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.registrationPresenter = RegistrationPresenter(delegate: self)
        initScreen()
        
        registerForKeyboardNotifications()
    }
    

    private func initScreen() {
        registerButton.layer.cornerRadius = 15
        errorLabel.layer.cornerRadius = 5
        errorLabel.layer.masksToBounds = true
        errorLabel.alpha = 0.0
        
        passwordTextField.delegate = self
        loginTextField.delegate = self
        repeatPasswordTextField.delegate = self
        
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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
        registrationLabel.isHidden = true
        guard let info = notification.userInfo else {
            shiftContainer.constant = -100
            return
        }
        guard let keyboardSize = info[UIResponder.keyboardFrameEndUserInfoKey]
                as? CGRect else {
            return
        }
        
        let constant = -keyboardSize.height * 3 / 5
        animateShift(pos: constant, alpha: 0.0)
    }
    
    @objc private func keyboardWillBeHidden(notification: Notification) {
        registrationLabel.isHidden = false
        
        animateShift(pos: 0, alpha: 1.0)
    }
    
    private func animateShift(pos: CGFloat, alpha: CGFloat) {
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveLinear, animations: {
            self.registrationLabel.alpha = alpha
            self.shiftContainer.constant = pos
            self.view.layoutIfNeeded()
          }, completion: { finished in
            print("Animation shift completed")
          })
    }
    
    private func animateErrorAppear(alpha: CGFloat) {
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveLinear, animations: {
            self.errorLabel.alpha = alpha
            self.view.layoutIfNeeded()
          }, completion: { finished in
            print("Animation error completed")
          })
    }
    
    @IBAction func registerButtonTouched(_ sender: Any) {
        self.registrationPresenter?.register(login: loginTextField.text?.trimmingCharacters(in: .whitespaces) ?? "", password: passwordTextField.text?.trimmingCharacters(in: .whitespaces) ?? "", repeatPassword: repeatPasswordTextField.text?.trimmingCharacters(in: .whitespaces) ?? "", phone: phone ?? "")
    }
    
//    @IBAction func loginButtonTouched(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
    
    deinit {
        print("dismiss")
        unregisterForKeyboardNotifications()
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension RegistrationViewController: RegistrationDelegate {
    func showProgress() {
        spinner.startAnimating()
    }
    
    func hideProgress() {
        spinner.stopAnimating()
    }
    
    func registrationDidSucceed() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func registrationDidFailed(message: String) {
        errorLabel.text = message
        if errorLabel.alpha != 1.0 {
            animateErrorAppear(alpha: 1.0)
        }
    }
}
