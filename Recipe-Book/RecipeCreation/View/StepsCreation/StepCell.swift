//
//  StepCell.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 20.11.2020.
//

import UIKit
import PinLayout

class StepCell: UICollectionViewCell {
    let text = UITextView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setup()
    }
    
    private func setup() {
        contentView.addSubview(text)
    
        text.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.topAnchor.constraint(equalTo: text.topAnchor, constant: 0).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: text.bottomAnchor, constant: 0).isActive = true
        self.contentView.leadingAnchor.constraint(equalTo: text.leadingAnchor, constant: 0).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: text.trailingAnchor, constant: 0).isActive = true
        
        let contentInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        text.contentInset = contentInsets
        
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 0.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 5.0
    }
}
