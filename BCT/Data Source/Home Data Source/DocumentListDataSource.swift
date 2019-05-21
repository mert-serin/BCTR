//
//  DocumentListDataSource.swift
//  BCT
//
//  Created by Mert Serin on 16.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

class DocumentListDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    
    weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            registerCell()
        }
    }
    
    private var documentDetailCellIdentifier = "DocumentDetailCell"
    private var documentHeaderCellIdentifier = "DocumentHeaderCell"
    
    var onSelectButtonTapped:((_ model:ListModel)->())?
    var waitingDocuments:[ListModel] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    var pastDocuments:[ListModel] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    
    var pageControl:UIPageControl!
    
    private func registerCell(){
        collectionView.register(UINib(nibName: documentDetailCellIdentifier, bundle: nil), forCellWithReuseIdentifier: documentDetailCellIdentifier)
        collectionView.register(UINib(nibName: documentHeaderCellIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: documentHeaderCellIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return waitingDocuments.count
        }else{
            return pastDocuments.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: documentDetailCellIdentifier, for: indexPath) as! DocumentDetailCell
        if indexPath.section == 0{
            cell.documentDetailView.model = waitingDocuments[indexPath.row]
        }else{
            cell.documentDetailView.model = pastDocuments[indexPath.row]
        }
        cell.onButtonTappedCompletion = onSelectButtonTapped
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: documentHeaderCellIdentifier, for: indexPath) as! DocumentHeaderCell
        if indexPath.section == 0{
            cell.headerLabel.text = "Waiting Signature"
        }else{
            cell.headerLabel.text = "Completed"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 && waitingDocuments.isEmpty{
            return CGSize(width: collectionView.frame.width, height: 0.0)
        }else if section == 1 && pastDocuments.isEmpty{
            return CGSize(width: collectionView.frame.width, height: 0.0)
        }
        
        return CGSize(width: collectionView.frame.width, height: 50.0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

}
