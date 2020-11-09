//
//  RecipeViewController.swift
//  Recipe-Book
//
//  Created by User on 16.10.2020.
//

import UIKit
import Cosmos

class RecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var ingridientCount: UILabel!
    @IBOutlet weak var ingridientsTableView: IngridientsTableView!
    @IBOutlet weak var stepsTableView: IngridientsTableView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var recipeNameView: UIView!
    @IBOutlet weak var recipeBlock: UIView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var backButton: UINavigationItem!
    
    var recipe: Recipe!
    
    var recipesViewController: RecipesViewContoller!
    var recipesIndexPath: IndexPath!
    
    var recipePresenter: RecipePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recipePresenter = RecipePresenter(delegate: self)
        
        recipeName.text = recipe.title
        recipeTime.text = String(recipe.cookingTime ) + " мин"
        ingridientCount.text = String(recipe?.ingredients.count ?? 0) + " ингридиентов"
        
        ratingView.rating = recipe.rating
        ratingView.settings.fillMode = .precise
        ratingView.settings.updateOnTouch = false
        
        let recipeId = recipe.id
        let indexPath = recipesIndexPath ?? IndexPath()
        ratingView.didTouchCosmos = { [weak self] rating in
            self?.recipePresenter?.vote(recipeId: recipeId, stars: lround(rating), indexPath: indexPath)
            self?.recipe.rating = rating
        }
        
        initTables()
        
        let contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.bounds)
        }
        scrollView.contentSize = contentRect.size
        
        let height = recipeBlock.frame.height
        scrollView.contentSize.height -= height
        
        recipeNameView.layer.shadowOpacity = 0.2
        recipeNameView.layer.shadowColor = UIColor.black.cgColor
        recipeNameView.layer.shadowRadius = 2
        recipeNameView.layer.shadowOffset = CGSize(width: 0, height: 2)
        recipeNameView.layer.masksToBounds = false
    }
    
    func initTables() {
        ingridientsTableView.delegate = self
        ingridientsTableView.dataSource = self
        ingridientsTableView.estimatedRowHeight = 24
        ingridientsTableView.rowHeight = UITableView.automaticDimension
        
        stepsTableView.delegate = self
        stepsTableView.dataSource = self
        stepsTableView.estimatedRowHeight = 50
        stepsTableView.rowHeight = UITableView.automaticDimension
        stepsTableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ingridientsTableView {
            return recipe.ingredients.count 
        }
        return recipe.steps.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == ingridientsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! IngridientTableViewCell
            
            cell.ingridientName?.text = recipe.ingredients[indexPath.item]
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! StepTableViewCell
        
        cell.stepNumber.text = "Шаг " + String(indexPath.item + 1)
        cell.stepText.text = recipe.steps[indexPath.item]
        
        return cell
    }
}

extension RecipeViewController: RecipeDelegate {
    
    func setRating(rating: Double, indexPath: IndexPath) {
        self.recipe.rating = rating
        self.ratingView.rating = rating
        
        self.recipesViewController.setRating(indexPath: indexPath, rating: rating)
    }
}
