//
//  RecepientsCell.swift
//  BCT
//
//  Created by Mert Serin on 17.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

class RecepientsCell: UICollectionViewCell {

    @IBOutlet weak var recepientNameLabel: UILabel!
    @IBOutlet weak var recepientEmailLabel: UILabel!
    @IBOutlet weak var documentStatusLabel: UILabel!
    
    var model:ListModel!{
        didSet{
            recepientNameLabel.text = model.user.name + " " + model.user.surname
            recepientEmailLabel.text = model.user.email
            documentStatusLabel.text = model.signStatus == "SIGNED" ? NSLocalizedString("Signed", comment: "") : NSLocalizedString("Pending", comment: "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
