//
//  ImageCell.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 18.11.2020.
//

import UIKit
import PinLayout

protocol InredientCellDelegate: NSObjectProtocol {
    func didTapEdit(index: IndexPath)
}

class IngredientCell: UITableViewCell {
    let editButton = UIButton(type: .system)
    let nameLabel = UILabel()
    let weightLabel = UILabel()
    let numberLabel = UILabel()
    
    weak var tableViewController: InredientCellDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }

    private func setup() {
        numberLabel.font = UIFont.systemFont(ofSize: 18)
        numberLabel.textColor = UIColor(named: "PastelDarkGreen")
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.textColor = .black
        weightLabel.font = UIFont.systemFont(ofSize: 12)
        weightLabel.textColor = .gray
        editButton.addTarget(self, action: #selector(IngredientCell.editCell(sender:)), for: .touchUpInside)
        editButton.setImage(UIImage(named: "scalemass.fill"), for: .normal)
        editButton.tintColor = UIColor(named: "PastelDarkGreen")
        editButton.backgroundColor = .red
        
        
        [numberLabel, nameLabel, weightLabel, editButton].forEach { contentView.addSubview($0) }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        numberLabel.pin
            .vCenter()
            .left(20)
            .sizeToFit()
        
        editButton.pin
            .vCenter()
            .right(20)
            .sizeToFit()
        
        nameLabel.pin
            .top(5)
            .right(of: numberLabel)
            .marginLeft(15)
            .sizeToFit()
        
        weightLabel.pin
            .bottom(5)
            .right(of: numberLabel)
            .marginLeft(15)
            .sizeToFit()
    }

    func configure(number: Int,
                   ingredient: Ingredient,
                   table: InredientCellDelegate) {
        tableViewController = table
        numberLabel.text = "\(number)"
        nameLabel.text = ingredient.name
        weightLabel.text = "\(ingredient.amount) \(ingredient.amountType.string)"
        
        setNeedsLayout()
    }
    
    @objc func editCell(sender: UIButton) {
        guard let superView = self.superview as? UITableView, let indexPath = superView.indexPath(for: self) else {
            print("cant get index of tapped row")
            return
        }
        
        tableViewController?.didTapEdit(index: indexPath)
    }
}
