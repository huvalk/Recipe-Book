//
//  LoginViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.10.2020.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var shiftConstraint: NSLayoutConstraint!
    @IBOutlet weak var errorShiftConstraint: NSLayoutConstraint!
    @IBOutlet weak var spaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputContainer: UIView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var lostPswdButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    let spinner = UIActivityIndicatorView(style: .large)
    
    var loginPresenter: LoginPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.loginPresenter = LoginPresenter(delegate: self)
        initScreen()
        
        registerForKeyboardNotifications()
    }
    
    private func initScreen() {
        loginButton.layer.cornerRadius = 15
        errorLabel.layer.cornerRadius = 5
        errorLabel.layer.masksToBounds = true
        errorLabel.alpha = 0.0
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func registerForKeyboardNotifications() {
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
        guard let keyboardSize = info[UIResponder.keyboardFrameEndUserInfoKey]
                as? CGRect else {
            return
        }
        
        let constant = -keyboardSize.height * 2 / 3
        animateShift(pos: constant, alpha: 0.0)
    }
    
    @objc private func keyboardWillBeHidden(notification: Notification) {
        loginLabel.isHidden = false
        
        animateShift(pos: 0, alpha: 1.0)
    }
    
    private func animateShift(pos: CGFloat, alpha: CGFloat) {
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveLinear, animations: {
            self.loginLabel.alpha = alpha
            self.shiftConstraint.constant = pos
            self.view.layoutIfNeeded()
          }, completion: nil)
    }
    
    private func animateErrorAppear(alpha: CGFloat) {
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveLinear, animations: {
            self.errorLabel.alpha = alpha
            self.view.layoutIfNeeded()
          }, completion: nil)
    }
    
    @IBAction func loginButtonTouched(_ sender: Any) {
        self.loginPresenter?.login(login: loginTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    @IBAction func registerButtonTouched(_ sender: Any) {
        let phoneViewController = self.storyboard?.instantiateViewController(withIdentifier: "PhoneViewController") as! PhoneViewController
        
        self.present(phoneViewController, animated: true)
    }
    
    @IBAction func lostPswdButtonTouched(_ sender: Any) {
        self.loginPresenter?.forgotPassword(login: loginTextField.text ?? "")
    }
    
    @IBAction func skipPswdButtonTouched(_ sender: Any) {
        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController

        mainViewController.modalPresentationStyle = .fullScreen
        self.present(mainViewController, animated: true)
    }
    
    deinit {
        unregisterForKeyboardNotifications()
    }
}

extension LoginViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string != " "
    }
}

extension LoginViewController: LoginDelegate {
    func showProgress() {
        spinner.startAnimating()
    }
    
    func hideProgress() {
        spinner.stopAnimating()
    }
    
    func loginDidSucceed() {
        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController

        mainViewController.modalPresentationStyle = .fullScreen
        self.present(mainViewController, animated: true)
    }
    
    func loginDidFailed(message: String) {
        errorLabel.backgroundColor = UIColor(named: "PastelDarkRed")
        errorLabel.textColor = .white
        errorLabel.text = message
        if errorLabel.alpha != 1.0 {
            animateErrorAppear(alpha: 1.0)
        }
    }
    
    func showMessage(message: String) {
        errorLabel.backgroundColor = UIColor(named: "TransperentGreen")
        errorLabel.textColor = .black
        errorLabel.text = message
        if errorLabel.alpha != 1.0 {
            animateErrorAppear(alpha: 1.0)
        }
    }
}
