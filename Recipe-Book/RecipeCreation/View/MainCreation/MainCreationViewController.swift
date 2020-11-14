//
//  MainCreationViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.11.2020.
//

import UIKit

class MainCreationViewController: UIViewController {
    @IBOutlet weak var pageSegmentedControll: CustomSegmentedControl! {
        didSet{
            pageSegmentedControll.setButtonTitles(buttonTitles: ["Ингредиенты","Шаги"])
            pageSegmentedControll.backgroundColor = .clear
            pageSegmentedControll.selectorViewColor = UIColor(named: "PastelDarkGreen") ?? .black
            pageSegmentedControll.selectorTextColor = UIColor(named: "PastelDarkGreen") ?? .black
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
