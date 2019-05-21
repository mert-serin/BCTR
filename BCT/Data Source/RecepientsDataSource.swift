//
//  RecepientsDataSource.swift
//  BCT
//
//  Created by Mert Serin on 17.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

class RecepientsDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    
    weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            registerCell()
        }
    }
    
    private var recepientsCellIdentifier = "RecepientsCell"
    
    var onSelectButtonTapped:(()->())?
    var model:[ListModel] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    
    private func registerCell(){
        collectionView.register(UINib(nibName: recepientsCellIdentifier, bundle: nil), forCellWithReuseIdentifier: recepientsCellIdentifier)
 
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recepientsCellIdentifier, for: indexPath) as! RecepientsCell
        cell.model = self.model[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
