//
//  SelectPlanetMainCollectionViewCell.swift
//  Tars
//
//  Created by ParkJunHyuk on 7/29/24.
//

import UIKit

import SnapKit
import Then

enum StateCell {
    case select
    case notSelect
}

class SelectPlanetMainCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "SelectPlanetMainCollectionViewCell"
    
    private var selectCell: StateCell = .notSelect {
        didSet {
            self.modifyLayoutCell()
        }
    }
    
    // MARK: - UI Properties
    
    private let planetBackgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth * 0.27, height: screenWidth * 0.17))
    private let planetImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth * 0.24, height: screenWidth * 0.24))
    private let planetNameLabel = UILabel()

    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureStyle()
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

extension SelectPlanetMainCollectionViewCell {
    func selectCellType(_ isSelected: Bool) {
        selectCell = isSelected ? .select : .notSelect
    }

    func configureCell(text: String, image: UIImage, selectCell: StateCell) {
        planetNameLabel.text = text
        planetNameLabel.textColor = .white
        planetImageView.image = image
        self.selectCell = selectCell
    }
    
    func accessibilityValueNameLabel() -> String {
        return planetNameLabel.text ?? ""
    }
}

// MARK: - Configure View Layout Private Extension

private extension SelectPlanetMainCollectionViewCell {
    func configureStyle() {
        planetBackgroundView.do {
            $0.image = UIImage(resource: .background)
        }
        
        planetImageView.do {
            $0.isUserInteractionEnabled = true
            $0.sizeToFit()
        }
        
        planetNameLabel.do {
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        }
    }
    
    func configureHierarchy() {
        self.addSubviews(planetImageView, planetNameLabel)
    }
    
    func configureLayout() {
        planetImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(screenHeight * 0.005)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(screenWidth * 0.34)
            $0.height.equalTo(screenHeight * 0.12)
        }
        
        planetNameLabel.snp.makeConstraints {
            $0.top.equalTo(planetImageView.snp.bottom)
            $0.centerX.equalTo(planetImageView)
        }
    }
    
    func modifyLayoutCell() {
        switch selectCell {
        case .notSelect:
            planetNameLabel.textColor = .white
            self.backgroundView = nil
            
        case .select:
            planetNameLabel.textColor = .black
            self.backgroundView = planetBackgroundView
        }
    }
}
