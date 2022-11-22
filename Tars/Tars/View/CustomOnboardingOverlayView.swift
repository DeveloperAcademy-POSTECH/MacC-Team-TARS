//
//  CustomOnboardingOverlayView.swift
//  Tars
//
//  Created by Seik Oh on 19/11/2022.
//

import UIKit

class CustomOnboardingOverlayView: UIView {

    lazy var coachingOnboardingLabel: UILabel = {
        let coachingOverlay = UILabel()
        coachingOverlay.text = PlanetStrings.onboardingInstructionTitle.localizedKey
        coachingOverlay.font = .preferredFont(forTextStyle: .largeTitle)
        coachingOverlay.textAlignment = .center
        if let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).withSymbolicTraits(.traitBold) {
            coachingOverlay.font = .init(descriptor: descriptor, size: 0)
        }
        coachingOverlay.textColor = .white
        coachingOverlay.adjustsFontForContentSizeCategory = true
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        return coachingOverlay
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureCoachingOverlay()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureCoachingOverlay() {
        
        [coachingOnboardingLabel].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            coachingOnboardingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            coachingOnboardingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            coachingOnboardingLabel.topAnchor.constraint(equalTo: self.topAnchor),
            coachingOnboardingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            coachingOnboardingLabel.widthAnchor.constraint(equalToConstant: screenWidth / 1.5),
            coachingOnboardingLabel.heightAnchor.constraint(equalToConstant: screenWidth / 1.5)
        ])
    }
}
