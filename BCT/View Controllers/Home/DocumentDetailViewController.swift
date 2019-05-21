//
//  DocumentDetailViewController.swift
//  BCT
//
//  Created by Mert Serin on 16.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

class DocumentDetailViewController: BaseViewController {
    
    enum DocumentStateTypes{
        case notSigned, signed, everybodySigned
    }
    
    @IBOutlet weak var recepientsCollectionView: UICollectionView!
    @IBOutlet weak var documentRecepientsContainerView: UIView!
    @IBOutlet weak var documentEverybodySignedContainerView: DocumentEverybodySigned!
    @IBOutlet weak var documentUserSignedContainerView: DocumentUserSigned!
    @IBOutlet weak var documentDetailView: DocumentDetailView!{
        didSet{
            documentDetailView.model = model
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var signLabel: UILabel!
    
    private var documentShowSegueIdentifier = "DocumentShowSegue"
    private var recepientsDataSource = RecepientsDataSource()
    private var listController = ListController()
    
    
    var currentDocumentState:DocumentStateTypes! = .notSigned{
        didSet{
            var documentRecepientsContainerViewAlpha:CGFloat = 0.0
            var documentEverybodySignedContainerViewAlpha:CGFloat = 0.0
            var documentUserSignedContainerViewAlpha:CGFloat = 0.0
            
            switch currentDocumentState! {
            case .notSigned:
                signButton.alpha = 1
                signLabel.alpha = 1
                titleLabel.text = NSLocalizedString("Sign", comment: "")
                documentRecepientsContainerViewAlpha = 1.0
                titleImageView.image = nil
            case .signed:
                signButton.alpha = 0
                signLabel.alpha = 0
                titleLabel.text = NSLocalizedString("Signed", comment: "")
                titleImageView.image = #imageLiteral(resourceName: "checked")
                documentUserSignedContainerViewAlpha = 1.0
            case .everybodySigned:
                signButton.alpha = 0
                signLabel.alpha = 0
                titleLabel.text = NSLocalizedString("Completed", comment: "")
                titleImageView.image = #imageLiteral(resourceName: "link-symbol")
                documentEverybodySignedContainerViewAlpha = 1.0
            }

            documentRecepientsContainerView.alpha = documentRecepientsContainerViewAlpha
            documentEverybodySignedContainerView.alpha = documentEverybodySignedContainerViewAlpha
            documentUserSignedContainerView.alpha = documentUserSignedContainerViewAlpha
        }
    }
    var model:ListModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        documentDetailView.onButtonTappedCompletion = { [weak self] (model) -> Void in
            self!.performSegue(withIdentifier: self!.documentShowSegueIdentifier, sender: self?.model)
        }
        
        recepientsDataSource.collectionView = self.recepientsCollectionView
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.documentShowSegueIdentifier{
            if let destinationVC = segue.destination as? DocumentShowViewController{
                destinationVC.model = sender as! ListModel
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshSignatures()
    }
    
    
    private func refreshSignatures(){
        listController.getMeetingSignatures(meetingId: model.meeting.id, username: super.user!.username) { (model, error) in
            if error != nil{
                print(error)
            }else{
                self.recepientsDataSource.model = model!.data
                if !model!.data.isEmpty{
                    self.model = model!.data.first!
                }
                let myUser = model!.data.filter({ (model) -> Bool in
                    return model.user.username == super.user!.username
                })
                
                self.documentUserSignedContainerView.model = myUser.first!
                
                if let first = myUser.first{
                    if first.signStatus == "SIGNED"{
                        self.currentDocumentState = .signed
                    }else{
                        self.currentDocumentState = .notSigned
                    }
                }
                
                let signedUsers = model!.data.filter({ (model) -> Bool in
                    return model.signStatus == "SIGNED"
                })
                
                self.documentDetailView.model = myUser.first!

                if model!.data.first!.meeting.status == "COMPLETED"{
                    self.documentEverybodySignedContainerView.model = myUser.first!
                    self.currentDocumentState = .everybodySigned
                }
                
            }
        }
    }

    
    @IBAction func onTappedSignButton(_ sender: UIButton) {
        
        listController.getMeetingSignatures(meetingId: model.meeting.id, username: super.user!.username) { (model, error) in
            if error != nil{
                print(error)
            }else{
                if !model!.data.isEmpty{
                    self.model = model!.data.first!
                }
                var xdr = StellarManager.signTransactionHash(hash: self.model.meeting.hash)
                self.listController.signDocument(username: super.user!.username, signedHash: xdr!, meetingId: self.model.meeting.meetingId) { (error) in
                    if error != nil{
                        print(error)
                    }else{
                        self.refreshSignatures()
                    }
                }
            }
        }
        

    }
    
}
