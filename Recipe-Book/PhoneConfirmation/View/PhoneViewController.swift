//
//  PhoneViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 17.10.2020.
//

import UIKit

class PhoneViewController: UIViewController {
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var shiftContainer: NSLayoutConstraint!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var codeButton: UIButton!
    let spinner = UIActivityIndicatorView(style: .large)
    
    var phonePresenter: PhonePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.phonePresenter = PhonePresenter(delegate: self)
        initScreen()
        
        registerForKeyboardNotifications()
    }
    

    private func initScreen() {
        confirmButton.layer.cornerRadius = 15
        codeButton.layer.cornerRadius = 15
        errorLabel.layer.cornerRadius = 5
        errorLabel.layer.masksToBounds = true
        errorLabel.alpha = 0.0
        
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
        phoneLabel.isHidden = true
        guard let info = notification.userInfo else {
            shiftContainer.constant = -100
            return
        }
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let constant = -(keyboardSize?.height ?? 100) * 3 / 5
        animateShift(pos: constant, alpha: 0.0)
    }
    
    @objc private func keyboardWillBeHidden(notification: Notification) {
        phoneLabel.isHidden = false
        
        animateShift(pos: 0, alpha: 1.0)
    }
    
    private func animateShift(pos: CGFloat, alpha: CGFloat) {
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveLinear, animations: {
            self.phoneLabel.alpha = alpha
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
    
    @IBAction func sendButtonTouched(_ sender: Any) {
        self.phonePresenter?.sendCode(phone: phoneTextField.text ?? "")
    }
    
    @IBAction func confirmButtonTouched(_ sender: Any) {
        self.phonePresenter?.confirmPhone(code: codeTextField.text ?? "")
    }
    
    deinit {
        print("dismiss")
        unregisterForKeyboardNotifications()
    }
}

extension PhoneViewController: PhoneDelegate {
    func showProgress() {
        spinner.startAnimating()
    }
    
    func hideProgress() {
        spinner.stopAnimating()
    }
    
    func phoneDidSucceed(phone: String) {
        let registrationViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        registrationViewController.phone = phone
        
        self.present(registrationViewController, animated: true)
    }
    
    func showMessage(message: String) {
        errorLabel.backgroundColor = UIColor(named: "TrasperentGreen")
        errorLabel.textColor = .black
        errorLabel.text = message
        if errorLabel.alpha != 1.0 {
            animateErrorAppear(alpha: 1.0)
        }
    }
    
    func phoneDidFailed(message: String) {
        errorLabel.backgroundColor = UIColor(named: "PastelDarkRed")
        errorLabel.textColor = .white
        errorLabel.text = message
        if errorLabel.alpha != 1.0 {
            animateErrorAppear(alpha: 1.0)
        }
    }
}
