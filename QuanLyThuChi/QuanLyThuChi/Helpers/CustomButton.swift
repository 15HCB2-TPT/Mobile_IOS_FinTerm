//
//  CustomButton.swift
//  QuanLyThuChi
//
//  Created by Shin-MacDesk on 6/7/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class RadioButton: UIButton {
    var alternateButton:Array<RadioButton>?
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
    }
    
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        }else{
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton(){
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = UIColor.green.cgColor
            } else {
                self.layer.borderColor = UIColor.darkGray.cgColor
            }
        }
    }
}

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "Checked")! as UIImage
    let uncheckedImage = UIImage(named: "UnChecked")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControlState.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControlState.normal)
            }
        }
    }
    
//    override func awakeFromNib() {
//        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
//        self.isChecked = false
//    }
//    
//    func buttonClicked(sender: UIButton) {
//        if sender == self {
//            isChecked = !isChecked
//        }
//    }
}
