//
//  UniverseMainViewController+DataSource.swift
//  Tars
//
//  Created by ParkJunHyuk on 7/29/24.
//

import UIKit

extension UniverseMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planetListData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectPlanetMainCollectionViewCell.identifier, for: indexPath) as? SelectPlanetMainCollectionViewCell
            else { return UICollectionViewCell() }
        
        if let image = UIImage(named: planetListData[indexPath.row].planetImage) {
            cell.configureCell(text: planetListData[indexPath.row].planetName, 
                               image: image,
                               selectCell: planetListData[indexPath.row].isSelected)
        }
        
        // VoiceOver 처리
        cell.isAccessibilityElement = true
        cell.accessibilityValue = cell.accessibilityValueNameLabel()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SelectPlanetMainCollectionViewCell else { return }
        
        if let previouseIndexPath = selectedIndexPath, previouseIndexPath != indexPath {
            planetListData[previouseIndexPath.row].isSelected = .notSelect
            collectionView.deselectItem(at: previouseIndexPath, animated: true)
            cell.selectCellType(cell.isSelected)
        }
        
        if selectedIndexPath == indexPath {
            selectedIndexPath = nil
            planetListData[indexPath.row].isSelected = .notSelect
            collectionView.deselectItem(at: indexPath, animated: true)
            cell.selectCellType(cell.isSelected)
        } else {
            selectedIndexPath = indexPath
            planetListData[indexPath.row].isSelected = .select
            cell.selectCellType(cell.isSelected)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SelectPlanetMainCollectionViewCell else { return }
        planetListData[indexPath.row].isSelected = .notSelect
        print("didDeselectItemAt", cell.isSelected, indexPath.row)
        
        cell.selectCellType(cell.isSelected)
    }
}
