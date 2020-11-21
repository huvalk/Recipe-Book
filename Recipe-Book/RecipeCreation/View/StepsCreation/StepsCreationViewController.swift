//
//  StepsCreationViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.11.2020.
//

import UIKit

class StepsCreationViewController: UIViewController {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let screen = UIScreen.main.bounds.size
        let cellWidth = screen.width * 0.7
        let cellHeight = CGFloat(200)
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.sectionFootersPinToVisibleBounds = false
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(named: "TransperentGreen")
        return cv
    }()
    
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        registerForKeyboardNotifications()
    }
    
    private func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StepCell.self, forCellWithReuseIdentifier: "StepCell")
        collectionView.register(HeaderStepCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "HeaderStepCell")
        
        view.addSubview(collectionView)
        
        self.bottomConstraint = self.view.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 0)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0).isActive = true
        self.bottomConstraint?.isActive = true
        self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 0).isActive = true
        self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: 0).isActive = true
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
        guard let info = notification.userInfo else {
            return
        }
        guard let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size else {
            return
        }
        
        self.bottomConstraint?.constant = keyboardSize.height
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillBeHidden(notification: Notification) {
        self.bottomConstraint?.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}

extension StepsCreationViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StepCell", for: indexPath) as! StepCell
        
        cell.text.text = "\(indexPath.row)"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderStepCell", for: indexPath)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 30, height: 10)
    }
}

extension StepsCreationViewController: UIScrollViewDelegate, UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let cellWidth = layout.itemSize.width + layout.minimumInteritemSpacing
        
        let oldOffset = targetContentOffset.pointee
        let index = (oldOffset.x + scrollView.contentInset.left) / cellWidth
        let roundedIndex = round(index)
        
        let newOffset = CGPoint(x: roundedIndex * cellWidth - scrollView.contentInset.left - layout.minimumLineSpacing, y: scrollView.contentInset.left)
        
        targetContentOffset.pointee = newOffset
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollingFinish("scrollViewDidEndScrollingAnimation")
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollingFinish("scrollViewDidEndDecelerating")
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollingFinish("scrollViewDidEndDragging")
        }
    }

    func scrollingFinish(_ string: String) -> Void {
        print("Scroll Finished! " + string)
    }
}
