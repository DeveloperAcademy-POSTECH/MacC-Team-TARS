//
//  CustomPlanetInfoView.swift
//  Tars
//
//  Created by Ayden on 2022/11/23.
//

import UIKit

class CustomPlanetInfoView: UIView {
    
    lazy var chapter: UILabel = {
        let chapter = UILabel()
        chapter.font = .preferredFont(forTextStyle: .title2)
        chapter.textColor = .white
        chapter.adjustsFontForContentSizeCategory = true
        return chapter
    }()
    
    lazy var planetInfoTitle: UILabel = {
        let planetInfoTitle = UILabel()
        planetInfoTitle.text = ""
        if let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title1).withSymbolicTraits(.traitBold) {
            planetInfoTitle.font = .init(descriptor: descriptor, size: 0)
        }
        planetInfoTitle.textColor = .white
        planetInfoTitle.textAlignment = .left
        planetInfoTitle.adjustsFontForContentSizeCategory = true
       return planetInfoTitle
    }()
    
//    lazy var planetInfoContents: UILabel = {
//        let planetInfoContents = UILabel()
//        planetInfoContents.text = ""
//        planetInfoContents.font = .preferredFont(forTextStyle: .title2)
//        planetInfoContents.textColor = .white
//        planetInfoContents.textAlignment = .left
//        planetInfoContents.numberOfLines = 0
//        planetInfoContents.setLineSpacing(spacing: 6)
//        planetInfoContents.adjustsFontForContentSizeCategory = true
//       return planetInfoContents
//    }()
    
    lazy var planetInfoContents: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "")
        let paragraphStyle = NSMutableParagraphStyle()
        
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = 0
        label.attributedText = attributedString
        label.textAlignment = .center
        paragraphStyle.lineSpacing = 10
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        label.textColor = .white
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
//        for i in planetContentsList {
//            planetInfoTitle.text = i.planetTitle1
//            planetInfoContents.text = i.planetContents1
//        }
        configurePlanetInfoContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configurePlanetInfoContents() {
        [chapter, planetInfoTitle, planetInfoContents].forEach { addSubview($0) }
        
        chapter.anchor(top: self.topAnchor,
                       leading: self.leadingAnchor,
                       trailing: self.trailingAnchor,
                       paddingLeading: screenWidth / 12.18)
        planetInfoTitle.anchor(top: chapter.bottomAnchor,
                               leading: self.leadingAnchor,
                               trailing: self.trailingAnchor,
                               paddingTop: screenHeight / 140.6,
                               paddingLeading: screenWidth / 12.18)
        planetInfoContents.anchor(top: planetInfoTitle.bottomAnchor,
                                  leading: self.leadingAnchor,
                                  bottom: self.bottomAnchor,
                                  trailing: self.trailingAnchor,
                                  paddingTop: screenHeight / 52.75,
                                  paddingLeading: screenWidth / 12.18,
                                  paddingBottom: screenHeight / 21.1,
                                  width: screenWidth / 1.19)
    }
}
