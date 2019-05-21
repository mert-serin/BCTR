//
//  WaitingSignDocumentCell.swift
//  BCT
//
//  Created by Mert Serin on 16.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

class WaitingSignDocumentCell: UICollectionViewCell {
    
    var onButtonTapCompletion:((_ model:ListModel)->())?

    @IBOutlet weak var documentNameTextView: UITextView!
    @IBOutlet weak var documentDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var model:ListModel!{
        didSet{
            documentNameTextView.text = model.meeting.subject
            documentDateLabel.text = model.creationDate.formatToDate(dateFormat: "dd-MM-yyyy")
        }
    }
    
    @IBAction func deeme(_ sender: Any) {
        onButtonTapCompletion?(model)
    }
}
