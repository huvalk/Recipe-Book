//
//  StepsCreationViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.11.2020.
//

import UIKit

class StepsCreationViewController: UIViewController {
    let collectionView: UICollectionView = {
        let layout = StepsCreationViewLayout()
        let screen = UIScreen.main.bounds.size
        let cellWidth = screen.width * 0.7
        let cellHeight = screen.height * 0.65
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(named: "TransperentGreen")
        return cv
    }()
    
    var bottomConstraint: NSLayoutConstraint?
    var steps: [String] = ["Готовь..."]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        registerForKeyboardNotifications()
    }
    
    private func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StepCell.self, forCellWithReuseIdentifier: "StepCell")
        
        view.addSubview(collectionView)
        
        self.bottomConstraint = self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomConstraint?.isActive = true
        self.view.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 0).isActive = true
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

        guard let keyboardSize = info[UIResponder.keyboardFrameEndUserInfoKey]
            as? CGRect else {
          return;
        }
        
        // размер tabBar
        let keyboardHeight = keyboardSize.height
        self.bottomConstraint?.constant = keyboardHeight - 50
        
        let layout = self.collectionView.collectionViewLayout as! StepsCreationViewLayout
        let screen = self.collectionView.bounds.size
        let cellWidth = screen.width * 0.7
        let cellHeight = screen.height - keyboardHeight
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        self.view.layoutIfNeeded()
    }
    
    @objc private func keyboardWillBeHidden(notification: Notification) {
        self.bottomConstraint?.constant = 0
        
        let layout = self.collectionView.collectionViewLayout as! StepsCreationViewLayout
        let screen = UIScreen.main.bounds.size
        let cellWidth = screen.width * 0.7
        let cellHeight = screen.height * 0.65
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        self.view.layoutIfNeeded()
    }
    
    func getData() -> [String] {
        return steps
    }
}

extension StepsCreationViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        steps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StepCell", for: indexPath) as! StepCell
        cell.stepDelegate = self
        cell.initiate(number: indexPath.row, text:  self.steps[indexPath.row])
        
        return cell
    }
}

extension StepsCreationViewController: StepDelegate {
    func finishedEditing(index: Int, range: NSRange, changes: String) {
        let text = steps[index] as NSString?
        
        text?.replacingCharacters(in: range, with: changes)
        steps[index] = text as String? ?? ""
    }
    
    func removeStepClicked(index: Int) {
        if steps.count == 1 {
            return
        }
        
        self.steps.remove(at: index)
        self.collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
        
        UIView.transition(with: collectionView, duration: 0.5, options: .transitionCrossDissolve, animations: {self.collectionView.reloadData()}, completion: nil)
    }
    
    func addStepClicked(index: Int) {
        self.steps.insert("Готовь...", at: index + 1)
        
        UIView.transition(with: collectionView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.collectionView.reloadData()
        }, completion: nil)
        
        self.collectionView.scrollToItem(at: IndexPath(row: index + 1, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension StepsCreationViewController: UIScrollViewDelegate, UICollectionViewDelegate {
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
