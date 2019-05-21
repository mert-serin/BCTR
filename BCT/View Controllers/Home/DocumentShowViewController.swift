//
//  DocumentShowViewController.swift
//  BCT
//
//  Created by Mert Serin on 16.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit
import WebKit

class DocumentShowViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var model:ListModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        webView.load(URLRequest(url: URL(string: model.meeting.reportUrl)!))
    }
    


}
