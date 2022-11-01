//
//  SelectPlanetViewController.swift
//  Tars
//
//  Created by 김소현 on 2022/10/21.
//

import UIKit

class SelectPlanetViewController: UIViewController {
    let contentsViewController = ContentsViewController()
    
    public let selectPlanetCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 1000
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SelectPlanetCollectionViewCell.self,
                                forCellWithReuseIdentifier: SelectPlanetCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 38, bottom: 0, right: 38)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectPlanetCollectionView.delegate = self
        selectPlanetCollectionView.dataSource = self
        
        view.backgroundColor = .white
        view.layer.masksToBounds = true

        view.addSubview(selectPlanetCollectionView)
        selectPlanetCollectionView.anchor(top: view.topAnchor, paddingTop: 300)
        selectPlanetCollectionView.setHeight(height: 300)
        selectPlanetCollectionView.setWidth(width: 390)
        selectPlanetCollectionView.centerX(inView: view)
    }
}

extension SelectPlanetViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = 109
        let cellHeight = 145
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension SelectPlanetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        
        let selectedPlanetName = planetList[indexPath.row].planetName
        let selectedPlanetImage = planetList[indexPath.row].planetImage
        
        if (cell?.isSelected) != nil {
            contentsViewController.setPlanet(name: selectedPlanetName, image: selectedPlanetImage ?? UIImage())
            navigationController?.pushViewController(contentsViewController, animated: true)
        }
    }
}
