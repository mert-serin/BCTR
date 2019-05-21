//
//  MnemonicViewController.swift
//  BCT
//
//  Created by Mert Serin on 16.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit
import stellarsdk

class MnemonicViewController: BaseViewController {
    
    @IBOutlet weak var mnemonicTextView: UITextView!
    
    private var homeSegueIdentifier = "showHomeSegue"
    
    var mnemonic:String?
    var keyPair:KeyPair?

    override func viewDidLoad() {
        super.viewDidLoad()

        mnemonicTextView.text = mnemonic
    }
    
    @IBAction func onTappedProceedButton(_ sender: UIButton) {
        
        UserDefaults.standard.set(mnemonic!, forKey: "\(user!.id)-mnemonic")
        UserDefaults.standard.set(keyPair!.secretSeed, forKey: "\(user!.id)-secretSeed")
        
        performSegue(withIdentifier: homeSegueIdentifier, sender: nil)
    }

    @IBAction func onTappedCopyButton(_ sender: UIButton) {
        //TO-DO alert
        UIPasteboard.general.string = mnemonic!
    }
}
