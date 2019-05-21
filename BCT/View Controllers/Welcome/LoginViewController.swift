//
//  LoginViewController.swift
//  BCT
//
//  Created by Mert Serin on 16.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit
import stellarsdk
class LoginViewController:BaseViewController{
    
    @IBOutlet weak var emailTextField: BCTTextField!{
        didSet{
            emailTextField.placeholder = NSLocalizedString("Name Surname", comment: "")
            emailTextField.textField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: BCTTextField!{
        didSet{
            passwordTextField.placeholder = NSLocalizedString("Email", comment: "")
            passwordTextField.textField.delegate = self
        }
    }
    
    private var mnemonicSegueIdentifier = "showMnemonicSegue"
    private var homeSegueIdentifier = "showHomeSegue"
    
    private var loginController = LoginController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == mnemonicSegueIdentifier{
            if let destinationVC = segue.destination as? MnemonicViewController{
                if  let senderModel = sender as? [Any],
                    let user = senderModel[0] as? LoginDataModel,
                    let mnemonic = senderModel[1] as? String,
                    let keyPair = senderModel[2] as? KeyPair{
                    destinationVC.mnemonic = mnemonic
                    destinationVC.keyPair = keyPair
                }
                
            }
        }
    }
    
    private func sentUserDetailsToAPI(){
        guard let name = emailTextField.getTextFieldValue(), name != "",
            let email = passwordTextField.getTextFieldValue(), email != "" else{
                return
        }
        super.showLoader()
        let mnemonic = StellarManager.generatePublicKey()
        let keyPair = StellarManager.generateSecretSeedFrom(mnemonic: mnemonic)
        
        loginController.loginWithValues(email: email, name: name, publicKey: keyPair!.publicKey.accountId) { (user, error) in
            if error != nil{
                super.dismissLoaderWithError()
                return
            }
            
            if user != nil{
                super.dismissLoader()
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(user) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: "User")
                }
                (UIApplication.shared.delegate as! AppDelegate).user = user
                self.performSegue(withIdentifier: self.mnemonicSegueIdentifier, sender: [user, mnemonic, keyPair])
            }
        }
    }
    
    
    @IBAction func onTappedCreateUserButton(_ sender: UIButton) {
        sentUserDetailsToAPI()
    }
    
}

extension LoginViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField.textField{
            passwordTextField.textField.becomeFirstResponder()
        }else{
            self.view.endEditing(true)
            sentUserDetailsToAPI()
        }
        return true
    }
}
