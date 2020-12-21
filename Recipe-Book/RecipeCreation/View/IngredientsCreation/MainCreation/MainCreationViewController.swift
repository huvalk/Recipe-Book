//
//  MainCreationViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.11.2020.
//

import UIKit
import PinLayout

final class MainCreationViewController: UIViewController {
    @IBOutlet weak var pageSegmentedControll: CustomSegmentedControl!
    lazy var generalViewController: GeneralCreationViewController = {
        return GeneralCreationViewController()
    }()
    lazy var stepsViewController: StepsCreationViewController = {
        return StepsCreationViewController()
    }()
    lazy var ingredientsViewController: IngredientsCreationViewController = {
        return IngredientsCreationViewController()
    }()
    var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private var presenter: MainCreationPresenter?
    let spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MainCreationPresenter(delegate: self)
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        setup()
        hideKeyboardWhenTappedAround()
    }
    
    private func setup() {
        setupSegmentControll()
        [pageViewController].forEach {
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
            formatedIngredients.append("\(ingredient.name) - \(ingredient.amount) \(ingredient.amountType.string)")
        }
        
        self.presenter?.saveRecipe(image: general.image, name: general.name, timeToCook: general.time, ingredients: formatedIngredients, steps: steps)
    }
}

extension MainCreationViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        switch pageSegmentedControll.selectedIndex {
        case 0:
            return nil
        case 1:
            return generalViewController
        case 2:
            return ingredientsViewController
        default:
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        switch pageSegmentedControll.selectedIndex {
        case 0:
            return ingredientsViewController
        case 1:
            return stepsViewController
        case 2:
            return nil
        default:
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed == false {
            return
        }
        
        guard let currentPage = self.pageViewController.viewControllers?[0] else {
            return
        }
        
        switch currentPage {
        case self.generalViewController:
            self.pageSegmentedControll.setIndex(index: 0)
        case self.ingredientsViewController:
            self.pageSegmentedControll.setIndex(index: 1)
        case self.stepsViewController:
            self.pageSegmentedControll.setIndex(index: 2)
        default:
            return
        }
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
            self.pageViewController.setViewControllers([self.generalViewController], direction: .reverse, animated: true, completion: nil)
        case 1:
            guard let currentPage = self.pageViewController.viewControllers?[0] else {
                return
            }
            var animationDirection = UIPageViewController.NavigationDirection.forward
            if currentPage == self.stepsViewController {
                animationDirection = UIPageViewController.NavigationDirection.reverse
            }
            self.pageViewController.setViewControllers([self.ingredientsViewController], direction: animationDirection, animated: true, completion: nil)
        case 2:
            self.pageViewController.setViewControllers([self.stepsViewController], direction: .forward, animated: true, completion: nil)
        default:
            return
        }
    }
}
