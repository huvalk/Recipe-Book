//
//  MainCreationViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.11.2020.
//

import UIKit
import PinLayout

class MainCreationViewController: UIViewController {
    @IBOutlet weak var pageSegmentedControll: CustomSegmentedControl!
    let generalViewController = GeneralCreationViewController()
    let stepsViewController = StepsCreationViewController()
    let ingredientsViewController = IngredientsCreationViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        self.generalViewController.view.isHidden = false
    }
    
    private func setup() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        
        setupSegmentControll()
        setupConstraints()
        [generalViewController,
         stepsViewController,
         ingredientsViewController].forEach {
            self.addChild($0)
            self.view.addSubview($0.view)
            $0.didMove(toParent: self)
         }
    }
    
    private func setupSegmentControll() {
        pageSegmentedControll.setButtonTitles(buttonTitles: ["Общее", "Ингредиенты", "Шаги"])
        pageSegmentedControll.backgroundColor = .clear
        pageSegmentedControll.selectorViewColor = UIColor(named: "PastelDarkGreen") ?? .black
        pageSegmentedControll.selectorTextColor = UIColor(named: "PastelDarkGreen") ?? .black
        pageSegmentedControll.delegate = self
        pageSegmentedControll.setIndex(index: 0)
        self.segmentChanged(to: 0)
    }
    
    private func setupConstraints() {
        generalViewController.view.pin
            .bottom()
            .top(120)
            .left()
            .right()
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let data = self.generalViewController.getData()
        
        print(data.name)
    }
}

extension MainCreationViewController: CustomSegmentedControlDelegate {
    func segmentChanged(to index: Int) {
        switch index {
        case 0:
            self.generalViewController.view.isHidden = false
            self.ingredientsViewController.view.isHidden = true
            self.stepsViewController.view.isHidden = true
        case 1:
            self.generalViewController.view.isHidden = true
            self.ingredientsViewController.view.isHidden = false
            self.stepsViewController.view.isHidden = true
        case 2:
            self.generalViewController.view.isHidden = true
            self.ingredientsViewController.view.isHidden = true
            self.stepsViewController.view.isHidden = false
        default:
            return
        }
    }
}
