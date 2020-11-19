//
//  PickTimeCell.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 18.11.2020.
//

import UIKit
import PinLayout

class PickTimeCell: UITableViewCell {
    let picker = UIPickerView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }

    private func setup() {
        picker.dataSource = self
        picker.delegate = self
        
        [picker].forEach { contentView.addSubview($0) }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
//        label.pin
//            .top(5)
//            .left(20)
//            .sizeToFit()
        
        picker.pin
            .top()
            .left(45)
            .right(45)
            .bottom()
    }

    func configure(with title: String) {
        setNeedsLayout()
    }
}

extension PickTimeCell: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 50
        case 2:
            return 60
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row)"
        case 2:
            return row < 10 ? "0\(row)" : "\(row)"
        default:
            return ":"
        }
    }
}
