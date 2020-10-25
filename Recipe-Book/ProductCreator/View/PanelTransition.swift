//
//  PanelTransition.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 25.10.2020.
//

import UIKit
import Foundation

class PanelTransition: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let dimm = DimmPresentationController(presentedViewController: presented, presenting: presenting ?? source)
        dimm.registerForKeyboardNotifications()
        return dimm
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }
}
