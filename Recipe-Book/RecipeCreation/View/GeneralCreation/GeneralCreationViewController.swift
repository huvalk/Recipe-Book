//
//  GeneralCreationViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.11.2020.
//

import UIKit
import PinLayout

protocol GeneralDelegate: class {
    func saveGeneral(info: String)
}

class GeneralCreationViewController: UIViewController {
    private let tableView = UITableView()
    
    weak var delegate: GeneralDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        self.view.backgroundColor = .orange
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(ImageCell.self, forCellReuseIdentifier: "ImageCell")
        tableView.register(InputCell.self, forCellReuseIdentifier: "InputCell")
        tableView.register(PickTimeCell.self, forCellReuseIdentifier: "PickTimeCell")
        
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

    }
    
    @objc private func keyboardWillBeHidden(notification: Notification) {

    }
}

extension GeneralCreationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return self.view.frame.width + 20
        case 1:
            return 120
        case 2:
            return 120
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
    
    func dismissTop() {
        self.dismiss(animated: true, completion: nil)
    }
}
