//
//  LaunchScreenViewController.swift
//  Tars
//
//  Created by Seik Oh on 15/11/2022.
//

import UIKit

import SnapKit
import Then

final class LaunchScreenViewController: UIViewController {
    
    // MARK: - Properties
    
    private var airPodsImage = UIImageView()
    private var airPodsInstruction = UILabel()
    private var appName = UILabel()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeGradientBackground()
        configureStyle()
        configureHierarchy()
        configureConstraints()
        configureAccessibility()
        navigateToUniverseVCWithDelay()
    }
}

// MARK: - Configure View Layout

private extension LaunchScreenViewController {
    
    func makeGradientBackground() {
        self.view.layer.configureGradientBackground(UIColor.customGradientPurple.cgColor, UIColor.customGradientBlue.cgColor)
    }
    
    func configureHierarchy() {
        view.addSubviews(airPodsImage, airPodsInstruction, appName)
    }
    
    func configureStyle() {
        airPodsImage.do {
            $0.image = UIImage(resource: .airpods)
            $0.contentMode = .scaleAspectFit
        }
        
        airPodsInstruction.do {
            let attributedString = NSMutableAttributedString(string: LocalizableKeys.airPodsInstructionstring.localized)
            $0.attributedText = attributedString
            $0.setBoldFont(forTextStyle: .title1)
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.textColor = .white
        }
        
        appName.do {
            let attributedString = NSMutableAttributedString(string: "SpaceOver")
            $0.attributedText = attributedString
            $0.font = .preferredFont(forTextStyle: .title2)
            $0.textAlignment = .center
            $0.textColor = .white
        }
    }
}

// MARK: - Auto Layout 설정

private extension LaunchScreenViewController {
    func configureConstraints() {
        airPodsImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-32)
            $0.width.height.equalTo(screenWidth * 0.6)
        }

        airPodsInstruction.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(screenWidth * 0.6)
            $0.top.equalTo(airPodsImage.snp.bottom).offset(16)
        }
        
        appName.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - accessibility 및 내비게이션 설정

private extension LaunchScreenViewController {
    
    /// accessibility 설정
    private func configureAccessibility() {
        airPodsInstruction.isAccessibilityElement = true
        airPodsInstruction.accessibilityLabel = LocalizableKeys.airPodsInstructionstring.localized
    }
    
    /// 화면 이동
    private func navigateToUniverseVCWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.airPodsInstruction.isAccessibilityElement = false
            
            let universeViewController = UniverseSearchViewController()
            self.navigationController?.pushViewController(universeViewController, animated: true)
            self.navigationController?.isNavigationBarHidden = true
        }
    }
}
