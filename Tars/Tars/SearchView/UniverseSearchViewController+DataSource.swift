//
//  UniverseSearchViewController+DataSource.swift
//  Tars
//
//  Created by 김소현 on 2022/11/04.
//

import UIKit

extension UniverseSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planetList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectPlanetCollectionViewCell.identifier, for: indexPath) as? SelectPlanetCollectionViewCell else { return UICollectionViewCell() }
        
        let selectedPlanetName = planetList[indexPath.row].planetName
        let selectedPlanetImage = planetList[indexPath.row].planetImage
        
        cell.planetNameLabel.text = selectedPlanetName
        cell.planetImageView.image = selectedPlanetImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectPlanetCollectionViewCell.identifier, for: indexPath) as? SelectPlanetCollectionViewCell
        
        let selectedPlanet = planetList[indexPath.row]
        
        if (cell?.isSelected) != nil {
            // TODO: 선택 시 동작 구현 (왜 안될까?)
            cell?.planetNameLabel.textColor = .black
            cell?.backgroundView = cell?.planetBackgroundView
//            contentsViewController.planet = selectedPlanet
//            navigationController?.pushViewController(contentsViewController, animated: true)
        }
    }
}
