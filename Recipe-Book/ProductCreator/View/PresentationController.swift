//
//  PresentationController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 25.10.2020.
//

import UIKit

class PresentationController: UIPresentationController {
    var additioanlHeight: CGFloat = 0
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        // Захардкожен размер полей ввода
        let height: CGFloat = 270
        return CGRect(x: 0, y: bounds.height - height - additioanlHeight, width: bounds.width, height: height + 50)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.addSubview(presentedView!)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWasShown(notification: Notification) {
        guard let containerView = containerView else {
            return
        }
        guard let info = notification.userInfo else {
            self.additioanlHeight = 100
            return
        }
        
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        self.additioanlHeight = keyboardSize?.height ?? 100

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            containerView.setNeedsLayout()
            containerView.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc private func keyboardWillBeHidden(notification: Notification) {
        guard let containerView = containerView else {
            return
        }
        self.additioanlHeight = 0

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            containerView.setNeedsLayout()
            containerView.layoutIfNeeded()
        }, completion: nil)
    }
    
    deinit {
        unregisterForKeyboardNotifications()
    }
}
