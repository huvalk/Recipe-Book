//
//  MainCreationViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.11.2020.
//

import UIKit

class MainCreationViewController: UIViewController {
    @IBOutlet weak var pageSegmentedControll: CustomSegmentedControl!
    let generalViewController = GeneralCreationViewController()
    let stepsViewController = StepsCreationViewController()
    let ingredientsViewController = IngredientsCreationViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSegmentControll()
        configureChildControllers()
        self.generalViewController.view.isHidden = false
    }
    
    private func configureSegmentControll() {
        pageSegmentedControll.setButtonTitles(buttonTitles: ["Общее", "Ингредиенты", "Шаги"])
        pageSegmentedControll.backgroundColor = .clear
        pageSegmentedControll.selectorViewColor = UIColor(named: "PastelDarkGreen") ?? .black
        pageSegmentedControll.selectorTextColor = UIColor(named: "PastelDarkGreen") ?? .black
        pageSegmentedControll.delegate = self
        pageSegmentedControll.setIndex(index: 0)
        self.segmentChanged(to: 0)
    }
    
    private func configureChildControllers() {
        configureChild(controller: generalViewController)
        configureChild(controller: ingredientsViewController)
        configureChild(controller: stepsViewController)
    }
    
    private func configureChild(controller: UIViewController) {
        addChild(controller)
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
        setConstraints(controller: controller)
    }
    
    private func setConstraints(controller: UIViewController) {
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.topAnchor.constraint(equalTo: pageSegmentedControll.bottomAnchor, constant: 5).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        controller.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        controller.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
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
