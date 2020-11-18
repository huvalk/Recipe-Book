//
//  InputCell.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 18.11.2020.
//

import UIKit

class InputCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .green
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension InputCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        activeField = textField
//        self.lastOffset = self.scrollView.contentOffset
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        activeField?.resignFirstResponder()
//        activeField = nil
        return true
    }
}
