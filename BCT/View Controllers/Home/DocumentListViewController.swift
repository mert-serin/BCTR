//
//  DocumentListViewController.swift
//  BCT
//
//  Created by Mert Serin on 16.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

class DocumentListViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var refreshControl:UIRefreshControl!
    private var showDocumentDetailSegueIdentifier = "ShowDocumentDetailSegue"
    
    let dataSource = DocumentListDataSource()
    private let listController = ListController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.collectionView = collectionView
        dataSource.onSelectButtonTapped = {(model) -> Void in
            self.performSegue(withIdentifier: self.showDocumentDetailSegueIdentifier, sender: model)
        }
        
        self.refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func refreshAction(){
        getAllList()
    }
    
    private func getAllList(){
        listController.getAllList(username: super.user!.username) { (model, error) in
            if error != nil{
                
            }else{
                self.dataSource.waitingDocuments = model!.data.filter({ (model) -> Bool in
                    print(model.signStatus)
                    return model.signStatus == "PENDING" && model.meeting.status != "COMPLETED"
                })
                
                self.dataSource.pastDocuments = model!.data.filter({ (model) -> Bool in
                    print(model.meeting.status)
                    return model.meeting.status == "COMPLETED"
                })
                
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showDocumentDetailSegueIdentifier{
            if let destinationVC = segue.destination as? DocumentDetailViewController{
                destinationVC.model = sender as! ListModel
            }
        }
    }
    



}
