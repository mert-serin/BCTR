//
//  BCTTextField.swift
//  BCT
//
//  Created by Mert Serin on 16.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

class BCTTextField: UIView {
    
    let kCONTENT_XIB_NAME = "BCTTextField"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        containerView.fixInView(self)
    }
    
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet private weak var textFieldLabel: UILabel!
    
    @IBOutlet weak var textFieldLabelHeightConstraint: NSLayoutConstraint!
    
    @IBAction func onTextFieldBeginEdit(_ sender: UITextField) {
        textFieldLabelHeightConstraint.constant = 20
        animateViewChanges()
    }
    
    @IBAction func onTextFieldEndEdit(_ sender: UITextField) {
        if textField.text == ""{
            textFieldLabelHeightConstraint.constant = 0
        }
        animateViewChanges()
    }
    
    var placeholder:String?{
        didSet{
            textField.placeholder = placeholder
            textFieldLabel.text = placeholder
        }
    }
    
    
    private func animateViewChanges(){
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: { [weak self] () -> Void in
            self?.layoutIfNeeded()
        }, completion: nil)
    }
    
    func getTextFieldValue() -> String?{
        return textField.text
    }
}
