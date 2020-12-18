//
//  ImageCell.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 18.11.2020.
//

import UIKit
import PinLayout

protocol NameDelegate: class {
    func finishedName(range: NSRange, changes: String)
}

class InputCell: UITableViewCell {
    let label = UILabel()
    let field = UITextField()
    weak var nameDelegate: NameDelegate?
    
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
        field.delegate = self
        
        [field].forEach { contentView.addSubview($0) }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
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
    
    func getData() -> String {
        var text = field.text ?? "Мой рецепт"
        if text.isEmpty {
            text = "Мой рецепт"
        }
        return text
    }
}

extension InputCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {        self.nameDelegate?.finishedName(range: range, changes: string)
            
        return true
    }
}
