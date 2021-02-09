//
//  PickTimeCell.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 18.11.2020.
//

import UIKit
import PinLayout

protocol TimeDelegate: class {
    func timePicked(time: Int)
}

class PickTimeCell: UITableViewCell {
    let timeToCookLabel = UILabel()
    let picker = UIPickerView()
    weak var timeDelegate: TimeDelegate?
    private var minute = 0
    private var hours = 0
    
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
        picker.backgroundColor = UIColor(named: "TransperentGreen")
        picker.layer.cornerRadius = 15.0
        timeToCookLabel.textColor = .black
        timeToCookLabel.font = UIFont.systemFont(ofSize: 16)
        timeToCookLabel.text = "Время на готовку"

        timeToCookLabel.textAlignment = NSTextAlignment.center;
        
        [picker, timeToCookLabel].forEach { contentView.addSubview($0) }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let timeToCookSize = timeToCookLabel.font.sizeOfString(string: timeToCookLabel.text!, constrainedToWidth: 0.0)
        
        timeToCookLabel.pin
            .top(15.0)
            .hCenter()
            .height(timeToCookSize.height + 14.0)
            .width(timeToCookSize.width + 20.0)
        picker.pin
            .below(of: timeToCookLabel)
            .hCenter()
            .marginTop(-30.0)
            .height(88)
            .right(45)
    }

    func configure(with title: String) {
        setNeedsLayout()
    }
    
    func getData() -> Int {
        return picker.selectedRow(inComponent: 0) * 60 + picker.selectedRow(inComponent: 2)
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hours = row * 60
        case 2:
            minute = row
        default:
            return
        }
        
        self.timeDelegate?.timePicked(time: hours + minute)
    }
}
