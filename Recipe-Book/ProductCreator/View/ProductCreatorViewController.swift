//
//  ProductCreatorViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 24.10.2020.
//

import UIKit

protocol DataTarget: NSObjectProtocol {
    func editFinished(index: IndexPath, ingredient: Ingredient)
    func createFinished(ingredient: Ingredient)
}

extension DataTarget {
    func editFinished(index: IndexPath, ingredient: Ingredient) {
        debugPrint("default implementation of protocol func")
    }
    
    func createFinished(ingredient: Ingredient) {
        debugPrint("default implementation of protocol func")
    }
}

class ProductCreatorViewController: UIViewController {
    enum Mode {
        case create
        case change
    }
    
    @IBOutlet weak var nameField: UITextField! 
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var typePeaker: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    
    var index: IndexPath?
    weak var dataTarget: DataTarget?
    var ingredient: Ingredient?
    var mode: Mode = .create {
        willSet {
            nameField.isUserInteractionEnabled = newValue  == .create
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typePeaker.dataSource = self
        typePeaker.delegate = self
        initScreen()
        hideKeyboardWhenTappedAround()
    }
    
    private func initScreen() {
        self.saveButton.layer.cornerRadius = 5
        self.weightField.keyboardType = UIKeyboardType.decimalPad
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let ingredient = ingredient {
            self.mode = .change
            
            UIView.transition(with: self.nameField,
                          duration: 0.25,
                           options: .transitionCrossDissolve,
                        animations: { [weak self] in
                            self?.nameField.text = ingredient.name
                     }, completion: nil)
            UIView.transition(with: self.weightField,
                          duration: 0.25,
                           options: .transitionCrossDissolve,
                        animations: { [weak self] in
                            self?.weightField.text = "\(ingredient.amount)"
                     }, completion: nil)
            self.typePeaker.selectRow(ingredient.amountType.rawValue, inComponent: 0, animated: true)
            
            self.weightField.becomeFirstResponder()
        } else {
            self.nameField.becomeFirstResponder()
        }
    }
    
    func setDefaultValue(ingredient: Ingredient, index: IndexPath) {
        self.ingredient = ingredient
        self.index = index
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        if let ingredient = self.ingredient {
            guard let index = self.index else {
                return
            }
            
            ingredient.amount = Double(self.weightField.text ?? "") ?? 0
            ingredient.amountType = Ingredient.AmountType(rawValue: self.typePeaker.selectedRow(inComponent: 0)) ?? Ingredient.AmountType.count
            dataTarget?.editFinished(index: index, ingredient: ingredient)
        } else {
            let newIngredient = Ingredient(name: self.nameField.text ?? "", amountType: Ingredient.AmountType(rawValue: self.typePeaker.selectedRow(inComponent: 0)) ?? Ingredient.AmountType.count, amount: Double(self.weightField.text ?? "") ?? 0, bought: false)
            dataTarget?.createFinished(ingredient: newIngredient)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ProductCreatorViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Ingredient.AmountType.length
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let type = Ingredient.AmountType(rawValue: row)
        return type?.string ?? "err"
    }
}
