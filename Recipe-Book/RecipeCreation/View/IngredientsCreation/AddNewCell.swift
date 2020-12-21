//
//  AddNewCell.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 19.11.2020.
//

import UIKit
import PinLayout

protocol AddNewCellDelegate: NSObjectProtocol {
    func didTapAdd()
}

class AddNewCell: UITableViewCell {
    let addButton = UIButton(type: .system)
    
    weak var addDelegate: AddNewCellDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }

    private func setup() {
        addButton.addTarget(self, action: #selector(AddNewCell.addNew(sender:)), for: .touchUpInside)
        let addImage = UIImage(named: "Plus")!
        addButton.imageView?.contentMode = .scaleAspectFit
        addButton.setImage(addImage, for: .normal)
        
        addButton.tintColor = UIColor(named: "PastelDarkGreen")
        
        
        [addButton].forEach { contentView.addSubview($0) }
    }
    
    @objc func addNew(sender: UIButton) {
        self.addDelegate?.didTapAdd()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        addButton.pin
            .vCenter()
            .hCenter()
            .height(20)
            .width(360)
            .marginHorizontal(320)
    }

    func configure(product: Product) {
        setNeedsLayout()
    }
}
