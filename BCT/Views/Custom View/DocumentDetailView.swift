//
//  DocumentDetailView.swift
//  BCT
//
//  Created by Mert Serin on 16.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

class DocumentDetailView: UIView {

    let kCONTENT_XIB_NAME = "DocumentDetailView"
    
    var onButtonTappedCompletion:((_ model:ListModel) -> ())?
    
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
            subjectLabel.text = model.meeting.subject
            fromLabel.text = "From: \(model.meeting.creatorEmail)"
            sentLabel.text = "Date: \(model.creationDate)"
            statusLabel.text = "Status: \(model.meeting.status == "PENDING" ? "Waiting for Signatures" : "Completed")"
        }
    }
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var sentLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    
    @IBAction func onTappedSelectButton(_ sender: Any) {
        onButtonTappedCompletion?(model)
    }
    
}
