//
//  HomeViewController.swift
//  BCT
//
//  Created by Mert Serin on 16.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet private weak var pageControl: UIPageControl!{
        didSet{
            signedDocument.pageControl = pageControl
        }
    }
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var documentDetailSegueIdentifier = "ShowDocumentSegue"
    private let signedDocument = HomeDataSource()
    private let listController = ListController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        signedDocument.collectionView = self.collectionView
        signedDocument.onSelectButtonTapped = { (model) -> Void in
            self.performSegue(withIdentifier: self.documentDetailSegueIdentifier, sender: model)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        listController.getAllList(username: user!.username) { (model, error) in
            if error != nil{
                print(error)
            }else{
                self.signedDocument.array = model!.data.filter({ (model) -> Bool in
                    return model.meeting.status != "COMPLETED"
                })
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == documentDetailSegueIdentifier{
            if let destinationVC = segue.destination as? DocumentDetailViewController{
                destinationVC.model = sender as! ListModel
            }
        }
    }
    


}
