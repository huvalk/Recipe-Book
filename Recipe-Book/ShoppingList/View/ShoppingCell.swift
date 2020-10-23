//
//  ShoppingCell.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 23.10.2020.
//

import UIKit

class ShoppingCell: UITableViewCell {
    @IBOutlet weak var Product: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
