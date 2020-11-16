//
//  ShoppingCell.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 23.10.2020.
//

import UIKit

protocol ShoppingCellDelegate: NSObjectProtocol {
    func didTapEdit(index: IndexPath)
    func didTapCheckBox(checked: Bool, index: IndexPath)
}

class ShoppingCell: UITableViewCell {
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var boughtCheckBox: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    let checkedImage = UIImage(named: "Checked")! as UIImage
    let uncheckedImage = UIImage(named: "Unchecked")! as UIImage

    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                boughtCheckBox.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                boughtCheckBox.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    
    weak var tableViewController: ShoppingCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isChecked = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(data: Product, delegate: ShoppingCellDelegate) {
        productLabel.text = data.name
        weightLabel.text = "\(data.amount) \(data.amountType.string)"
        self.isChecked = data.bought
        tableViewController = delegate
    }

    @IBAction func editButtonTapped(_ sender: UIButton) {
        guard let superView = self.superview as? UITableView, let indexPath = superView.indexPath(for: self) else {
            print("cant get index of tapped row")
            return
        }
        
        tableViewController?.didTapEdit(index: indexPath)
    }

    @IBAction func boughtClicked(sender: UIButton) {
        guard let superView = self.superview as? UITableView, let indexPath = superView.indexPath(for: self) else {
            print("cant get index of tapped row")
            return
        }
        
        self.isChecked = !self.isChecked
        tableViewController?.didTapCheckBox(checked: self.isChecked, index: indexPath)
    }
}
