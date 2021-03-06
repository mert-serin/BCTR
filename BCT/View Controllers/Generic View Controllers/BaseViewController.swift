//
//  BaseViewController.swift
//  BCT
//
//  Created by Mert Serin on 16.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit
import KVNProgress
class BaseViewController: UIViewController {
    
    var user:LoginDataModel?{
        get{
            return (UIApplication.shared.delegate as! AppDelegate).user
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTap()
    }
    
    func hideKeyboardWhenTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.didTapAnywhereOnBase))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        tap.cancelsTouchesInView = true
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func didTapAnywhereOnBase() {
        self.view.endEditing(true)
    }

    
    func showLoader(){
        KVNProgress.show()
    }
    
    func dismissLoader(){
        KVNProgress.dismiss()
    }
    
    func dismissLoaderWithError(){
        KVNProgress.showError()
    }
}
