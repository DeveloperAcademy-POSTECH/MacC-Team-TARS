//
//  UniverseSearchViewController+FlowLayoutDelegate.swift
//  Tars
//
//  Created by 김소현 on 2022/11/04.
//

import UIKit

extension UniverseSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = screenWidth * 0.27
        let cellHeight = screenHeight * 0.17
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
