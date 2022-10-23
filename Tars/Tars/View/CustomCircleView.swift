//
//  GuideCircleView.swift
//  Tars
//
//  Created by Lena on 2022/10/22.
//

import UIKit

class CustomCircleView: UIView {

    lazy var guideCircleView: UIView = {
        let circleView = UIView()
        circleView.backgroundColor = .clear
        circleView.frame = CGRect(x: 0, y: 0, width: screenWidth / 1.5, height: screenWidth / 1.5)
        circleView.layer.cornerRadius = self.frame.width / 2
        circleView.clipsToBounds = true
        circleView.layer.masksToBounds = true
        circleView.addDashedCircle()
        circleView.translatesAutoresizingMaskIntoConstraints = false
        return circleView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureCircle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureCircle() {

        addSubview(guideCircleView)
        
        NSLayoutConstraint.activate([
            guideCircleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            guideCircleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            guideCircleView.topAnchor.constraint(equalTo: self.topAnchor),
            guideCircleView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            guideCircleView.widthAnchor.constraint(equalToConstant: screenWidth / 1.5),
            guideCircleView.heightAnchor.constraint(equalToConstant: screenWidth / 1.5)
        ])
    }
}


