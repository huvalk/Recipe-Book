//
//  StepCell.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 20.11.2020.
//

import UIKit
import PinLayout

protocol StepDelegate: class {
    func removeStepClicked(index: Int)
    func addStepClicked(index: Int)
    func finishedEditing(index: Int, range: NSRange, changes: String)
}

class StepCell: UICollectionViewCell {
    let numberLabel = UILabel()
    let addButton = UIButton()
    let deleteButton = UIButton(type: .system)
    let text = UITextView()
    var number: Int = 0 {
        didSet {
            numberLabel.text = "Шаг \(number + 1)"
        }
    }
    
    weak var stepDelegate: StepDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setup()
    }
    
    public func initiate(number: Int, text: String) {
        self.text.text = text
        self.number = number
    }
    
    private func setup() {
        numberLabel.textColor = UIColor(named: "PastelGreen")
        numberLabel.font = UIFont.systemFont(ofSize: 16)
        addButton.setImage(UIImage(named: "Plus"), for: .normal)
        addButton.tintColor = UIColor(named: "PastelGreen")
        addButton.backgroundColor = .white
        addButton.layer.cornerRadius = 5
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.tintColor = .gray
        deleteButton.backgroundColor = .white
        deleteButton.layer.cornerRadius = 5
        numberLabel.textAlignment = .center
        text.backgroundColor = UIColor(named: "TransperentGreen")
        text.layer.cornerRadius = 5
        
        text.delegate = self
        
        [numberLabel, text, addButton, deleteButton].forEach { contentView.addSubview($0) }
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.centerYAnchor.constraint(equalTo: self.addButton.centerYAnchor).isActive = true
        self.addButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        self.addButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        self.addButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        addButton.addTarget(self, action: #selector(StepCell.addStep(sender:)), for: .touchUpInside)
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.topAnchor.constraint(equalTo: deleteButton.topAnchor, constant: 0).isActive = true
        self.contentView.leadingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: 0).isActive = true
        self.deleteButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        self.deleteButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        deleteButton.addTarget(self, action: #selector(StepCell.removeStep(sender:)), for: .touchUpInside)
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.topAnchor.constraint(equalTo: numberLabel.topAnchor, constant: 0).isActive = true
        self.numberLabel.leadingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: 10).isActive = true
        self.numberLabel.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        self.numberLabel.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        
        text.translatesAutoresizingMaskIntoConstraints = false
        self.numberLabel.bottomAnchor.constraint(equalTo: text.topAnchor, constant: -5).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: text.bottomAnchor, constant: 5).isActive = true
        self.contentView.leadingAnchor.constraint(equalTo: text.leadingAnchor, constant: -5).isActive = true
        self.text.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -5).isActive = true
        
        self.backgroundColor = .white
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
            
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 1.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 5.0
    }
    
    @objc func addStep(sender: Any) {
        self.stepDelegate?.addStepClicked(index: number)
    }
    
    @objc func removeStep(sender: Any) {
        self.stepDelegate?.removeStepClicked(index: number)
    }
}

extension StepCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.stepDelegate?.finishedEditing(index: number, range: range, changes: text)
        
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
