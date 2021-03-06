//
//  DocumentUserSigned.swift
//  BCT
//
//  Created by Mert Serin on 16.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

class DocumentUserSigned: UIView {

    let kCONTENT_XIB_NAME = "DocumentUserSigned"
    
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
    
    var model:ListModel!{
        didSet{
            nameLabel.text = "Name: \(model.user.name) \(model.user.surname)"
            statusLabel.text = "Status: \(model.signStatus == "PENDING" ? "Pending" : "Signed")"
            dateLabel.text = "Date: \(model.meeting.creationDate)"
            emailLabel.text = "Email: \(model.user.email)"
        }
    }
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    

}
