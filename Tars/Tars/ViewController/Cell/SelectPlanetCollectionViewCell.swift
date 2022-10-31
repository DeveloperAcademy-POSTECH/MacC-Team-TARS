//
//  SelectPlanetCollectionViewCell.swift
//  Tars
//
//  Created by 김소현 on 2022/10/24.
//

import UIKit

class SelectPlanetCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "SelectPlanetCollectionViewCell"
    
    let planetBackgroundView: UIImageView = {
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 109, height: 145))
        imageView.image = UIImage(named: "BackgroundImage")
        return imageView
    }()
    
    let planetImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 95, height: 95))
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "default")
        imageView.sizeToFit()
        return imageView
    }()
    
    let planetNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "default"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    override func layoutSubviews() {
        self.backgroundView = planetBackgroundView
        
        [planetImageView, planetNameLabel].forEach {
            self.contentView.addSubview($0)
        }
        
        planetImageView.anchor(top: self.topAnchor, paddingTop: 5)
        planetImageView.centerX(inView: self)
        planetImageView.setWidth(width: 135)
        planetImageView.setHeight(height: 105)
        
        planetNameLabel.anchor(top: planetImageView.bottomAnchor)
        planetNameLabel.centerX(inView: planetImageView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
