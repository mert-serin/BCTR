//
//  DocumentDetailCell.swift
//  BCT
//
//  Created by Mert Serin on 16.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

class DocumentDetailCell: UICollectionViewCell {

    @IBOutlet weak var documentDetailView: DocumentDetailView!
    
    var onButtonTappedCompletion:((_ model:ListModel) -> ())?{
        didSet{
            documentDetailView.onButtonTappedCompletion = onButtonTappedCompletion
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
