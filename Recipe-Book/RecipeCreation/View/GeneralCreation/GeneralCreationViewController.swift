//
//  GeneralCreationViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.11.2020.
//

import UIKit
import PinLayout

class GeneralCreationViewController: UIViewController {
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        hideKeyboardWhenTappedAround()
    }
    
    private func setup() {
        registerForKeyboardNotifications()
        self.view.backgroundColor = .orange
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(ImageCell.self, forCellReuseIdentifier: "ImageCell")
        tableView.register(InputCell.self, forCellReuseIdentifier: "InputCell")
        tableView.register(PickTimeCell.self, forCellReuseIdentifier: "PickTimeCell")
        tableView.allowsSelection = false
        
        view.addSubview(tableView)
        self.tableView.pin
            .top()
            .bottom()
            .left()
            .right()
        
        tableView.frame = view.frame
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
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0);
        tableView.contentInset = contentInsets
        
        tableView.scrollToRow(at: IndexPath(row: 0, section: 2), at: .top, animated: true)
        tableView.scrollIndicatorInsets = tableView.contentInset
    }
    
    @objc private func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0);
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = tableView.contentInset
    }
    
    func getData() -> (image: UIImage, name: String, time: Int) {
        let imageCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ImageCell

        let inputCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! InputCell

        let pickTimeCell = tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! PickTimeCell

        return (imageCell.getData(), inputCell.getData(), pickTimeCell.getData())
    }
}

extension GeneralCreationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return self.view.frame.width + 20
        case 1:
            return 50
        case 2:
            return 80
        default:
            return 20
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
            cell.presenter = self
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell") as! InputCell
            cell.configure(with: "Название")
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PickTimeCell") as! PickTimeCell
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension GeneralCreationViewController: TableViewControllerPresenter {
    func showViewController(_ controller: UIViewController, animated: Bool, completion: (() -> ())?) {
        self.present(controller, animated: animated, completion: nil)
    }
    
    func imageSelected(image: UIImage?) {
        self.dismiss(animated: true, completion: nil)
    }
}
