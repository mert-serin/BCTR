//
//  HomeDataSource.swift
//  BCT
//
//  Created by Mert Serin on 16.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

class HomeDataSource:NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    
    weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            registerCell()
        }
    }
    
    private var waitingSignDocumentCellIdentifier = "WaitingSignDocumentCell"
    private var emptySignDocumentCellIdentifier = "EmptySignedDocumentCell"

    var onSelectButtonTapped:((_ model:ListModel)->())?
    
    var array:[ListModel] = []{
        didSet{
            collectionView.reloadData()
            pageControl.numberOfPages = array.count
            if !array.isEmpty{
                collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionView.ScrollPosition.left, animated: true)
                pageControl.currentPage = 0
                pageControl.isHidden = false
            }else{
                pageControl.isHidden = true
            }
        }
    }
    
    var pageControl:UIPageControl!

    private func registerCell(){
        collectionView.register(UINib(nibName: "WaitingSignDocumentCell", bundle: nil), forCellWithReuseIdentifier: waitingSignDocumentCellIdentifier)
        collectionView.register(UINib(nibName: "EmptySignedDocumentCell", bundle: nil), forCellWithReuseIdentifier: emptySignDocumentCellIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.isEmpty ? 1 : array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if array.isEmpty{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emptySignDocumentCellIdentifier, for: indexPath) as! EmptySignedDocumentCell
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: waitingSignDocumentCellIdentifier, for: indexPath) as! WaitingSignDocumentCell
            cell.model = array[indexPath.row]
            cell.onButtonTapCompletion = self.onSelectButtonTapped
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / collectionView.frame.width)
    }
    
}
