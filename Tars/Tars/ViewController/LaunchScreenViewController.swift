//
//  LaunchScreenViewController.swift
//  Tars
//
//  Created by Seik Oh on 15/11/2022.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    // MARK: - Properties
    
    private let airPodsInstruction: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: PlanetStrings.airPodsInstructionstring.localizedKey)
        let paragraphStyle = NSMutableParagraphStyle()
        
        label.font = .preferredFont(forTextStyle: .largeTitle)
        if let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title1).withSymbolicTraits(.traitBold) {
            label.font = .init(descriptor: descriptor, size: 0)
        }
        label.numberOfLines = 0
        label.attributedText = attributedString
        label.textAlignment = .center
        paragraphStyle.lineSpacing = 10
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        label.textColor = .white
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [airPodsInstruction].forEach { view.addSubview($0) }
        configureConstraints()
        
        airPodsInstruction.isAccessibilityElement = true
        airPodsInstruction.accessibilityLabel = PlanetStrings.airPodsInstructionstring.localizedKey
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.airPodsInstruction.isAccessibilityElement = false
            let universeVC = UniverseSearchViewController()
            self.navigationController?.pushViewController(universeVC, animated: true)
            self.navigationController?.isNavigationBarHidden = true
        }
    }
    
    private func configureConstraints() {
        airPodsInstruction.anchor(leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingLeading: screenWidth / 9.75, paddingTrailing: screenWidth / 9.75)
        airPodsInstruction.centerX(inView: view)
        airPodsInstruction.centerY(inView: view)
    }
}
