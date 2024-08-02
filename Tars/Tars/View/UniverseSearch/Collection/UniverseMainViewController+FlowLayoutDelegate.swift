//
//  UniverseMainViewController+FlowLayoutDelegate.swift
//  Tars
//
//  Created by ParkJunHyuk on 7/29/24.
//

import UIKit

extension UniverseMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = screenWidth * 0.27
        let cellHeight = screenHeight * 0.17
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
