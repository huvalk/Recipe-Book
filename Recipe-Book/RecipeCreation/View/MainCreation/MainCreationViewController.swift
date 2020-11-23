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
        hideKeyboardWhenTappedAround()
        self.generalViewController.view.isHidden = false
    }
    
    private func setup() {
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor(named: "PastelDarkGreen") ?? .black
        
        setupSegmentControll()
        [generalViewController,
         stepsViewController,
         ingredientsViewController].forEach {
            self.addChild($0)
            self.view.addSubview($0.view)
            $0.didMove(toParent: self)
            setupConstraints(controller: $0)
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
    
    private func setupConstraints(controller: UIViewController) {
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.topAnchor.constraint(equalTo: pageSegmentedControll.bottomAnchor, constant: 5).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        controller.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        controller.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
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
