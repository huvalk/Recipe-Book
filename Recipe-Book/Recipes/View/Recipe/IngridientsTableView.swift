//
//  IngridientsTableView.swift
//  Recipe-Book
//
//  Created by User on 17.10.2020.
//

import UIKit

class IngridientsTableView: UITableView {
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width, height: contentSize.height)
    }
}
