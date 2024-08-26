//
//  CustomPlanetInfoView.swift
//  Tars
//
//  Created by Ayden on 2022/11/23.
//

import UIKit

import SnapKit
import Then

class CustomPlanetInfoView: UIView {
    
    var chapter = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .title2)
        $0.textColor = .white
        $0.adjustsFontForContentSizeCategory = true
    }
    
    var planetInfoTitle = UILabel().then {
        if let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title1).withSymbolicTraits(.traitBold) {
            $0.font = .init(descriptor: descriptor, size: 0)
        }
        $0.textColor = .white
        $0.textAlignment = .left
        $0.adjustsFontForContentSizeCategory = true
        $0.adjustsFontSizeToFitWidth = true
    }
    
    var planetInfoContents = UILabel().then {
        let attributedString = NSMutableAttributedString(string: String())
        let paragraphStyle = NSMutableParagraphStyle().then {
            $0.hyphenationFactor = 1
            $0.lineSpacing = 18
        }
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        $0.font = .preferredFont(forTextStyle: .title2)
        $0.numberOfLines = 0
        $0.attributedText = attributedString
        $0.textAlignment = .justified
        $0.lineBreakMode = .byCharWrapping
        $0.textColor = .white
        $0.adjustsFontForContentSizeCategory = true
    }
    
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
        
        setAccessibilityLabels()
    }
    
    public func setContentsIndex(planet: Planet, chapterIndex: Int) {
        let chapterNumber = "Chapter \(chapterIndex)"
        let titlesAndContents = planet.titlesAndContents
        
        let (title, content) = titlesAndContents[chapterIndex - 1]
        let localizedTitle = LocalizableKeys(from: title)?.localized ?? String()
        let localizedContent = LocalizableKeys(from: content)?.localized ?? String()
        
        setInfoContents(chapter: chapterNumber, title: localizedTitle, contents: localizedContent)
    }
    
    private func configurePlanetInfoContents() {
        [chapter, planetInfoTitle, planetInfoContents].forEach { addSubview($0) }
        
        self.isAccessibilityElement = false
        self.accessibilityElements = [chapter, planetInfoTitle, planetInfoContents]
        
        let chapterPadding = screenWidth / 12.18
        let width = screenWidth / 1.19
        
        chapter.snp.makeConstraints {
            $0.top.equalToSuperview().offset(screenWidth / 12.18)
            $0.leading.trailing.equalTo(self).inset(chapterPadding)
            $0.width.lessThanOrEqualTo(screenWidth)
            $0.height.lessThanOrEqualTo(36)
        }
        
        planetInfoTitle.snp.makeConstraints {
            $0.top.equalTo(chapter.snp.bottom)
            $0.leading.trailing.equalTo(self).inset(chapterPadding)
            $0.width.lessThanOrEqualTo(screenWidth)
            $0.height.lessThanOrEqualTo(48)
        }
        
        planetInfoContents.snp.makeConstraints {
            $0.top.equalTo(planetInfoTitle.snp.bottom).offset(screenWidth / 12.18)
            $0.leading.trailing.equalTo(self).inset(chapterPadding)
            $0.bottom.equalToSuperview().offset(-screenWidth / 12.18)
            $0.width.lessThanOrEqualTo(screenWidth)
            $0.height.lessThanOrEqualTo(screenHeight / 1.5)
        }
    }
    
    private func setAccessibilityLabels() {
        self.chapter.accessibilityLabel = self.chapter.text
        self.planetInfoTitle.accessibilityLabel = self.planetInfoTitle.text
        self.planetInfoContents.accessibilityLabel = self.planetInfoContents.text
    }
}
