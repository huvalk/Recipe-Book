//
//  ShoppingViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 23.10.2020.
//

import UIKit

class ShoppingViewController: UIViewController {
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.dataSource = self
        table.delegate = self
    }
}

extension ShoppingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        
        return cell
    }
    
    
}
