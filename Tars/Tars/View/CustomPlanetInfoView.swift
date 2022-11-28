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
        chapter.isAccessibilityElement = true
        return chapter
    }()
    
    lazy var planetInfoTitle: UILabel = {
        let planetInfoTitle = UILabel()
        if let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title1).withSymbolicTraits(.traitBold) {
            planetInfoTitle.font = .init(descriptor: descriptor, size: 0)
        }
        planetInfoTitle.textColor = .white
        planetInfoTitle.textAlignment = .left
        planetInfoTitle.adjustsFontForContentSizeCategory = true
        planetInfoTitle.isAccessibilityElement = true
       return planetInfoTitle
    }()
    
    lazy var planetInfoContents: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "")
        let paragraphStyle = NSMutableParagraphStyle()
        
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = 0
        label.attributedText = attributedString
        // 텍스트 양쪽 정렬, 문자 단위로 라인 넘어가기에 관련한 코드입니다.
        label.textAlignment = .justified
        label.lineBreakMode = .byCharWrapping
        paragraphStyle.hyphenationFactor = 1
        
        paragraphStyle.lineSpacing = 18
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        label.textColor = .white
        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configurePlanetInfoContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func setInfoContents(chapter: String, title: String, contents: String) {
        self.chapter.text = chapter
        self.planetInfoTitle.text = title
        self.planetInfoContents.text = contents
        
        self.chapter.accessibilityLabel = chapter
        self.planetInfoTitle.accessibilityLabel = title
        self.planetInfoContents.accessibilityLabel = contents
    }
    
    private func configurePlanetInfoContents() {
        [chapter, planetInfoTitle, planetInfoContents].forEach { addSubview($0) }
        
        self.isAccessibilityElement = false
        self.accessibilityElements = [chapter, planetInfoTitle, planetInfoContents]
        
        chapter.anchor(top: self.topAnchor,
                       leading: self.leadingAnchor,
                       trailing: self.trailingAnchor,
                       paddingLeading: screenWidth / 12.18,
                       width: screenWidth / 1.19)
        planetInfoTitle.anchor(top: chapter.bottomAnchor,
                               leading: self.leadingAnchor,
                               trailing: self.trailingAnchor,
                               paddingLeading: screenWidth / 12.18,
                               width: screenWidth / 1.19)
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
