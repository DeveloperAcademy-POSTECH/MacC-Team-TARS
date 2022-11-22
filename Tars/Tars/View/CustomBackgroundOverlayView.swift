//
//  CustomBackgroundOverlayView.swift
//  Tars
//
//  Created by Seik Oh on 19/11/2022.
//

import UIKit

class CustomBackgroundOverlayView: UIView {
    
    lazy var coachingOnboardingBackground: UIView = {
        let background = UIView()
        background.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureBackgroundOverlay()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureBackgroundOverlay() {
        
        [coachingOnboardingBackground].forEach { addSubview($0) }
        
        coachingOnboardingBackground.anchor(width: screenWidth, height: screenHeight)
    }
}
