//
//  RecipeViewController.swift
//  Recipe-Book
//
//  Created by User on 16.10.2020.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var ingridientCount: UILabel!
    @IBOutlet weak var ingridientsTableView: IngridientsTableView!
    @IBOutlet weak var stepsTableView: IngridientsTableView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var recipeNameView: UIView!
    
    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeName.text = recipe.title
        recipeTime.text = String(recipe.cookingTime ) + " мин"
        ingridientCount.text = String(recipe?.ingredients.count ?? 0) + " ингридиентов"
        
        initTables()
        
        let contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        scrollView.contentSize = contentRect.size
        
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
        stepsTableView.estimatedRowHeight = 100
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
