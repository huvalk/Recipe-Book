//
//  StepCell.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 20.11.2020.
//

import UIKit
import PinLayout

class HeaderStepCell: UICollectionViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setup()
    }
    
    private func setup() {
        backgroundColor = .black
    }
}

