//
//  CustomSquareView.swift
//  Tars
//
//  Created by Lena on 2022/10/24.
//

import UIKit

class CustomSquareView: UIView {

    lazy var squareView: UIView = {
        let squareView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth / 5.65, height: screenWidth / 5.65))
        squareView.backgroundColor = .clear
        squareView.layer.borderWidth = 2
        squareView.layer.borderColor = UIColor.customYellow.cgColor
        squareView.translatesAutoresizingMaskIntoConstraints = false
        return squareView
    }()
    
    lazy var planetLabel: UILabel = {
        let planetLabel = UILabel()
        planetLabel.frame = CGRect(x: 0, y: 0, width: screenWidth / 5.65, height: screenHeight / 26.375)
        planetLabel.text = "수성"
        planetLabel.textAlignment = .center
        planetLabel.font = .systemFont(ofSize: 24)
        planetLabel.textColor = .black
        planetLabel.backgroundColor = .customYellow
        planetLabel.translatesAutoresizingMaskIntoConstraints = false
        return planetLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureSquare()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureSquare() {
        
        [squareView, planetLabel].forEach { addSubview($0) }
        
        squareView.anchor(top: self.topAnchor,
                           leading: self.leadingAnchor,
                           bottom: planetLabel.topAnchor,
                           trailing: self.trailingAnchor,
                           width: screenWidth / 5.65,
                           height: screenWidth / 5.65)
        
        planetLabel.anchor(top: squareView.bottomAnchor,
                           leading: self.leadingAnchor,
                           bottom: self.bottomAnchor,
                           trailing: self.trailingAnchor,
                           width: screenWidth / 5.65,
                           height: screenHeight / 26.375)
    }
    
    func setLabel(_ name: String) {
        self.planetLabel.text = name
    }
}
