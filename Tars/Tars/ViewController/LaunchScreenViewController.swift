//
//  LaunchScreenViewController.swift
//  Tars
//
//  Created by Seik Oh on 15/11/2022.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    // MARK: - Properties
    
    private let airPodsImage: UIImageView = {
        let airPodsImage = UIImageView()
        airPodsImage.image = UIImage(named: "airpods.png")
        airPodsImage.contentMode = .scaleAspectFit
        return airPodsImage
    }()
    
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
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "SpaceOver")
        let paragraphStyle = NSMutableParagraphStyle()
        
        label.font = .preferredFont(forTextStyle: .footnote)
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
        
        self.view.layer.configureGradientBackground(UIColor.customGradientPurple.cgColor, UIColor.customGradientBlue.cgColor)
        
        [airPodsInstruction, airPodsImage, appNameLabel].forEach { view.addSubview($0) }
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
        airPodsImage.centerX(inView: view)
        airPodsImage.anchor(paddingTop: screenHeight / 21.6, width: screenWidth / 2.21, height: screenWidth / 1.56)
        NSLayoutConstraint.activate([
            airPodsImage.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight / 3.81)
            ])
        
        airPodsInstruction.anchor(leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingLeading: screenWidth / 9.75, paddingTrailing: screenWidth / 9.75)
        NSLayoutConstraint.activate([
            airPodsInstruction.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            airPodsInstruction.topAnchor.constraint(equalTo: airPodsImage.bottomAnchor, constant: 0)
        ])
        
        appNameLabel.anchor(leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingLeading: screenWidth / 9.75, paddingTrailing: screenWidth / 9.75)
        NSLayoutConstraint.activate([
            appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appNameLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 4)
        ])
        
    }
}

extension CALayer {
    public func configureGradientBackground(_ colors: CGColor...) {
        let gradient = CAGradientLayer()
        let maxWidth = max(self.bounds.size.height, self.bounds.size.width)
        let squareFrame = CGRect(origin: self.bounds.origin, size: CGSize(width: maxWidth, height: maxWidth))
        gradient.frame = squareFrame
        gradient.colors = colors
        self.insertSublayer(gradient, at: 0)
    }
}
