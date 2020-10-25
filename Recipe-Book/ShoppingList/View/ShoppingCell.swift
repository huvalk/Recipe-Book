//
//  ShoppingCell.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 23.10.2020.
//

import UIKit

protocol ShoppingCellDelegate: NSObjectProtocol {
    func didTapEdit(index: IndexPath)
}

class ShoppingCell: UITableViewCell {
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var boughtCheckBox: CheckBox!
    @IBOutlet weak var editButton: UIButton!
    
    weak var tableViewController: ShoppingCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(data: Product, delegate: ShoppingCellDelegate) {
        productLabel.text = data.name
        weightLabel.text = "\(data.amount) \(data.amountType.string)"
        boughtCheckBox.isChecked = data.bought
        tableViewController = delegate
    }

    @IBAction func editButtonTapped(_ sender: UIButton) {
        guard let superView = self.superview as? UITableView, let indexPath = superView.indexPath(for: self) else {
            print("cant get index of tapped row")
            return
        }
        
        tableViewController?.didTapEdit(index: indexPath)
    }
}
