//
//  InfoViewController.swift
//  Tars
//
//  Created by Ayden on 2022/10/24.
//

import UIKit

class InfoViewController: UIViewController {
    lazy var planetImageView: UIImageView = {
        let planetImage = UIImageView()
        planetImage.image = UIImage(named: "jupiter")
        planetImage.contentMode = .scaleAspectFill
        return planetImage
    }()
    
    lazy var planetName: UILabel = {
        let planetName = UILabel()
        planetName.text = "목성"
        planetName.font = .preferredFont(forTextStyle: .largeTitle)
        planetName.textColor = .white
        planetName.adjustsFontForContentSizeCategory = true
        return planetName
    }()
    
    lazy var planetInfo: UILabel = {
        let planetInfo = UILabel()
        planetInfo.text = "목성은 태양계의 다섯번째 행성이자 가장 큰 행성이다. 태양의 질량의 1,000분의 1배에 달하는 거대행성으로, 태양계에 있는 다른 모든 행성들을 합한 질량의 약 2.5배에 이른다"
        planetInfo.font = .preferredFont(forTextStyle: .title3)
        planetInfo.textColor = .white
        planetInfo.adjustsFontForContentSizeCategory = true
        planetInfo.numberOfLines = 0
        return planetInfo
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        [planetImageView, planetName, planetInfo].forEach { view.addSubview($0) }
        configureConstraints()
    }
    
    private func configureConstraints() {
        planetImageView.centerX(inView: view)
        planetImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: screenHeight / 21.6, width: screenWidth / 1.41, height: screenWidth / 1.41)
        
        planetName.centerX(inView: view)
        planetName.anchor(top: planetImageView.bottomAnchor, paddingTop: screenHeight / 35.1)
        
        planetInfo.centerX(inView: view)
        planetInfo.anchor(top: planetName.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: screenWidth / 52.7, paddingLeading: screenWidth / 9.75, paddingTrailing: screenWidth / 9.75)
    }
}
