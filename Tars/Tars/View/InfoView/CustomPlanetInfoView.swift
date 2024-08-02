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
    
    /*
    lazy var chapter: UILabel = {
        let chapter = UILabel()
        chapter.font = .preferredFont(forTextStyle: .title2)
        chapter.textColor = .white
        chapter.adjustsFontForContentSizeCategory = true
        return chapter
    }()
    
    lazy var planetInfoTitle: UILabel = {
        let planetInfoTitle = UILabel()
        if let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title1).withSymbolicTraits(.traitBold) {
            planetInfoTitle.font = .init(descriptor: descriptor, size: 0)
        }
        planetInfoTitle.textColor = .white
        planetInfoTitle.textAlignment = .left
        planetInfoTitle.numberOfLines = 0
        planetInfoTitle.adjustsFontForContentSizeCategory = true
       return planetInfoTitle
    }()
    
    lazy var planetInfoContents: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: String())
        let paragraphStyle = NSMutableParagraphStyle()
        
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = 0
        label.attributedText = attributedString
        
        label.textAlignment = .justified
        label.lineBreakMode = .byCharWrapping
        paragraphStyle.hyphenationFactor = 1
        
        paragraphStyle.lineSpacing = 18
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        label.textColor = .white
        label.adjustsFontForContentSizeCategory = true
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
    
    public func setContentsIndex(planet: Planet, chapterIndex: Int) {
        let chapterNumber = "Chapter \(chapterIndex)"
        let titlesAndContents = planet.titlesAndContents
        
        guard chapterIndex > 0 && chapterIndex <= titlesAndContents.count else {
            print("Invalid chapter index")
            return
        }
        
        let (title, content) = (titlesAndContents[chapterIndex - 1].0, titlesAndContents[chapterIndex - 1].1)
        let localizedTitle = LocalizableKeys(from: title)?.localized ?? String()
        let localizedContent = LocalizableKeys(from: content)?.localized ?? String()
        
        setInfoContents(chapter: chapterNumber, title: localizedTitle, contents: localizedContent)
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
     */
    
    lazy var chapter = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .title2)
        $0.textColor = .white
        $0.adjustsFontForContentSizeCategory = true
    }
    
    lazy var planetInfoTitle = UILabel().then {
        if let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title1).withSymbolicTraits(.traitBold) {
            $0.font = .init(descriptor: descriptor, size: 0)
        }
        $0.textColor = .white
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.adjustsFontForContentSizeCategory = true
    }
    
    lazy var planetInfoContents = UILabel().then {
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
           
           guard chapterIndex > 0 && chapterIndex <= titlesAndContents.count else {
               print("Invalid chapter index")
               return
           }
           
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
               $0.top.equalToSuperview()
               $0.leading.trailing.equalToSuperview().inset(chapterPadding)
               $0.width.equalTo(width)
           }
           
           planetInfoTitle.snp.makeConstraints {
               $0.top.equalTo(chapter.snp.bottom)
               $0.leading.trailing.equalToSuperview().inset(chapterPadding)
               $0.width.equalTo(width)
           }
           
           planetInfoContents.snp.makeConstraints {
               $0.top.equalTo(planetInfoTitle.snp.bottom).offset(screenHeight / 52.75)
               $0.leading.trailing.equalToSuperview().inset(chapterPadding)
               $0.bottom.equalToSuperview().inset(screenHeight / 21.1)
               $0.width.equalTo(width)
           }
       }
       
       private func setAccessibilityLabels() {
           self.chapter.accessibilityLabel = self.chapter.text
           self.planetInfoTitle.accessibilityLabel = self.planetInfoTitle.text
           self.planetInfoContents.accessibilityLabel = self.planetInfoContents.text
       }
}
