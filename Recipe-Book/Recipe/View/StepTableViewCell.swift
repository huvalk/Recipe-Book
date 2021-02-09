//
//  StepTableViewCell.swift
//  Recipe-Book
//
//  Created by User on 17.10.2020.
//

import UIKit

class StepTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stepNumber: UILabel!
    @IBOutlet weak var stepText: UILabel!
    
    func configure(number: Int, text: String) {
        self.stepNumber.text = "Шаг " + String(number)
        self.stepText.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
