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
    lazy var generalViewController = GeneralCreationViewController()
    lazy var stepsViewController = StepsCreationViewController()
    lazy var ingredientsViewController = IngredientsCreationViewController()
    private var presenter: MainCreationPresenter?
    let spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MainCreationPresenter(delegate: self)
        
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
        
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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
        let general = self.generalViewController.getData()
        let ingredients = self.ingredientsViewController.getData()
        let steps = self.stepsViewController.getData()
        
        var formatedIngredients: [String] = []
        for ingredient in ingredients {
            formatedIngredients.append("\(ingredient.name) \(ingredient.amountType) \(ingredient.amountType.string)")
        }
        
        self.presenter?.saveRecipe(image: general.image, name: general.name, timeToCook: general.time, ingredients: formatedIngredients, steps: steps)
    }
}

extension MainCreationViewController: MainCreationDelegate {
    func startLoad() {
        self.spinner.startAnimating()
    }
    
    func endLoad() {
        self.spinner.stopAnimating()
    }
    
    func loadSucceed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadFailed() {
        self.navigationController?.popViewController(animated: true)
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
