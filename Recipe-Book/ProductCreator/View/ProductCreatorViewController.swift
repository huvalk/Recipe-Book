//
//  ProductCreatorViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 24.10.2020.
//

import UIKit

protocol DataTarget: NSObjectProtocol {
    func editFinished(index: IndexPath, product: Product)
    func createFinished(product: Product)
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
    weak var target: DataTarget?
    var product: Product?
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
        
        if let product = product {
            self.mode = .change
            
            UIView.transition(with: self.nameField,
                          duration: 0.25,
                           options: .transitionCrossDissolve,
                        animations: { [weak self] in
                            self?.nameField.text = product.name
                     }, completion: nil)
            UIView.transition(with: self.weightField,
                          duration: 0.25,
                           options: .transitionCrossDissolve,
                        animations: { [weak self] in
                            self?.weightField.text = "\(product.amount)"
                     }, completion: nil)
            self.typePeaker.selectRow(product.amountType.rawValue, inComponent: 0, animated: true)
            
            self.weightField.becomeFirstResponder()
        } else {
            self.nameField.becomeFirstResponder()
        }
    }
    
    func setDefaultValue(product: Product, index: IndexPath) {
        self.product = product
        self.index = index
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        if var product = self.product {
            guard let index = self.index else {
                return
            }
            
            product.amount = Double(self.weightField.text ?? "") ?? 0
            product.amountType = Product.AmountType(rawValue: self.typePeaker.selectedRow(inComponent: 0)) ?? Product.AmountType.count
            target?.editFinished(index: index, product: product)
        } else {
            let newProduct = Product(name: self.nameField.text ?? "", amountType: Product.AmountType(rawValue: self.typePeaker.selectedRow(inComponent: 0)) ?? Product.AmountType.count, amount: Double(self.weightField.text ?? "") ?? 0, bought: false)
            target?.createFinished(product: newProduct)
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
        Product.AmountType.length
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let type = Product.AmountType(rawValue: row)
        return type?.string ?? "err"
    }
}
