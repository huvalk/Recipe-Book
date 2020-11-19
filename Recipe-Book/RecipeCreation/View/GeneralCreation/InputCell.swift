//
//  ImageCell.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 18.11.2020.
//

import UIKit
import PinLayout

class InputCell: UITableViewCell {
    let label = UILabel()
    let field = UITextField()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }

    private func setup() {
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        field.layer.cornerRadius = 5
        field.backgroundColor = UIColor(named: "TransperentGreen")
        field.font = UIFont.systemFont(ofSize: 15)
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.keyboardType = UIKeyboardType.default
        field.returnKeyType = UIReturnKeyType.done
        field.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        field.placeholder = "Название"
        
        [field].forEach { contentView.addSubview($0) }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
//        label.pin
//            .top(5)
//            .left(20)
//            .sizeToFit()
        
        field.pin
            .bottom(5)
            .height(40)
            .left(20)
            .right(20)
    }

    func configure(with title: String) {
        setNeedsLayout()
        
        label.text = title
    }
}
