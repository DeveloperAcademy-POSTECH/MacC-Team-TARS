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
        chapter.text = "Chapter 1"
        chapter.font = .preferredFont(forTextStyle: .title2)
        chapter.textColor = .white
        chapter.adjustsFontForContentSizeCategory = true
        return chapter
    }()
    
    lazy var planetInfoTitle: UILabel = {
        let planetInfoTitle = UILabel()
        planetInfoTitle.text = planetContentsList[0].planetInfoFirstTitle
        if let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title1).withSymbolicTraits(.traitBold) {
            planetInfoTitle.font = .init(descriptor: descriptor, size: 0)
        }
        planetInfoTitle.textColor = .white
        planetInfoTitle.textAlignment = .left
        planetInfoTitle.adjustsFontForContentSizeCategory = true
       return planetInfoTitle
    }()
    
    lazy var planetInfoContents: UILabel = {
        let planetInfoContents = UILabel()
        planetInfoContents.text = planetContentsList[0].planetInfoFirstContents
        planetInfoContents.font = .preferredFont(forTextStyle: .title2)
        planetInfoContents.textColor = .white
        planetInfoContents.textAlignment = .left
        planetInfoContents.numberOfLines = 0
        planetInfoContents.setLineSpacing(spacing: 6)
        planetInfoContents.adjustsFontForContentSizeCategory = true
       return planetInfoContents
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configurePlanetInfoContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configurePlanetInfoContents() {
        [chapter, planetInfoTitle, planetInfoContents].forEach { addSubview($0) }
        
        chapter.anchor(top: self.topAnchor, leading: self.leadingAnchor, paddingLeading: screenWidth / 12.18)
        planetInfoTitle.anchor(top: chapter.bottomAnchor, leading: self.leadingAnchor, paddingTop: screenHeight / 140.6, paddingLeading: screenWidth / 12.18)
        planetInfoContents.anchor(top: planetInfoTitle.bottomAnchor, leading: self.leadingAnchor, paddingTop: screenHeight / 52.75, paddingLeading: screenWidth / 12.18, width: screenWidth / 1.19)
    }
}
