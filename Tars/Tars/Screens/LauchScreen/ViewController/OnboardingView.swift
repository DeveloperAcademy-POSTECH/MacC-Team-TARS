//
//  OnboardingViewController.swift
//  Tars
//
//  Created by Lena on 2024/7/29.
//

import UIKit

import SnapKit
import Then

class OnboardingView: UIView {
    
    private var coachingOnboardingLabel = UILabel()
    private var onboardingBackground = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureSubviews()
        configureBackground()
        configureLabel()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

private extension OnboardingView {
    
    func configureLabel() {
        coachingOnboardingLabel.do {
            $0.text = LocalizableKeys.onboardingInstructionTitle.localized
            $0.font = .preferredFont(forTextStyle: .largeTitle)
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.adjustsFontSizeToFitWidth = true
            if let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).withSymbolicTraits(.traitBold) {
                $0.font = .init(descriptor: descriptor, size: 0)
            }
            $0.textColor = .white
            $0.adjustsFontForContentSizeCategory = true
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func configureBackground() {
        onboardingBackground.do {
            $0.backgroundColor = .black.withAlphaComponent(0.6)
        }
    }
    
    func configureLayout() {
        
        onboardingBackground.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(screenWidth)
            $0.height.equalTo(screenHeight)
        }
        
        coachingOnboardingLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(screenHeight / 3.45)
            $0.width.height.lessThanOrEqualToSuperview().multipliedBy(0.6)
        }
    }
}

private extension OnboardingView {
    func configureSubviews() {
        self.addSubview(onboardingBackground)
        onboardingBackground.addSubview(coachingOnboardingLabel)
    }
}
