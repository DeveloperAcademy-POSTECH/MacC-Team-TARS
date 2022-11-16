//
//  LaunchScreenViewController.swift
//  Tars
//
//  Created by Seik Oh on 15/11/2022.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    // MARK: - Properties
    
    private let AirPodsInstruction: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: PlanetStrings.airPodsInstructions.localizedKey)
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
        [AirPodsInstruction].forEach { view.addSubview($0) }
        configureConstraints()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            print("test")
            let universeVC = UniverseViewController()
            self.navigationController?.pushViewController(universeVC, animated: true)
            self.navigationController?.isNavigationBarHidden = true
        }
    }
    
    private func configureConstraints() {
        AirPodsInstruction.anchor(leading: view.leadingAnchor, trailing: view.trailingAnchor)
        AirPodsInstruction.centerX(inView: view)
        AirPodsInstruction.centerY(inView: view)
    }
    
}
