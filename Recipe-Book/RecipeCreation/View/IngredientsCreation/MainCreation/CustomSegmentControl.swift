//
//  CustomSegmentControl.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.11.2020.
//

import UIKit
protocol CustomSegmentedControlDelegate: class {
    func segmentChanged(to index:Int)
}

class CustomSegmentedControl: UIView {
    private var buttonTitles:[String]!
    private var sizeOfTitles:[CGSize]!
    private var virtualWidth:CGFloat!
    private var buttons: [UIButton]!
    private var selectorView: UIView!
    
    var textColor:UIColor = .black
    var selectorViewColor: UIColor = .red
    var selectorTextColor: UIColor = .red
    
    weak var delegate:CustomSegmentedControlDelegate?
    weak var actionDelegate:CustomSegmentedControlDelegate?
    
    public private(set) var selectedIndex : Int = 0
    
    convenience init(frame:CGRect,buttonTitle:[String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitle
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = UIColor.white
        updateView()
    }
    
    func setButtonTitles(buttonTitles:[String]) {
        self.buttonTitles = buttonTitles
        self.sizeOfTitles = [CGSize]()
        self.virtualWidth = CGFloat()
        for buttonTitle in self.buttonTitles {
            let size = UIFont.systemFont(ofSize: 16).sizeOfString(string: buttonTitle, constrainedToWidth: Double(self.frame.width))
            sizeOfTitles.append(size)
            self.virtualWidth += size.width
        }
        self.updateView()
    }
    
    func setIndex(index:Int) {
        buttons.forEach({ $0.setTitleColor(textColor, for: .normal) })
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        let selectorPosition = selectorCalculatePos(index: selectedIndex)
        let selectorWidth = selectorCalculateWidth(index: selectedIndex)
        UIView.animate(withDuration: 0.2) {
            self.selectorView.frame = CGRect(x: selectorPosition, y: self.frame.height, width: selectorWidth, height: 2)
        }
    }
    
    private func selectorCalculatePos(index: Int) -> CGFloat {
        var selectorPosition: CGFloat = 0
        for i in 0..<index {
            selectorPosition += sizeOfTitles[i].width
        }
        
        return selectorPosition * self.frame.width / virtualWidth
    }
    
    private func selectorCalculateWidth(index: Int) -> CGFloat {
        let selectorWidth = sizeOfTitles[index].width
        
        return selectorWidth * self.frame.width / virtualWidth
    }
    
    @objc func buttonAction(sender:UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender && selectedIndex != buttonIndex {
                selectedIndex = buttonIndex
                delegate?.segmentChanged(to: selectedIndex)
                let selectorWidth = selectorCalculateWidth(index: selectedIndex)
                let selectorPosition = selectorCalculatePos(index: selectedIndex)
                UIView.animate(withDuration: 0.2) {
                    self.selectorView.frame = CGRect(x: selectorPosition, y: self.frame.height, width: selectorWidth, height: 2)
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
}

//Configuration View
extension CustomSegmentedControl {
    private func updateView() {
        createButton()
        configSelectorView()
        configStackView()
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 0
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func configSelectorView() {
        let selectorWidth = selectorCalculateWidth(index: 0)
        let selectorPos = selectorCalculatePos(index: 0)
        selectorView = UIView(frame: CGRect(x: selectorPos, y: self.frame.height, width: selectorWidth, height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action:#selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
    }
}
