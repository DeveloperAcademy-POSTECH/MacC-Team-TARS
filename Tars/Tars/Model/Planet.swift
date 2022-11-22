//
//  Planet.swift
//  Tars
//
//  Created by 김소현 on 2022/10/25.
//

import UIKit

struct Planet {
    var planetKoreanName: String
    var planetEnglishName: String
    var planetImage: UIImage?
    
    init(planetKoreanName: String, planetImage: UIImage?) {
        self.planetKoreanName = planetKoreanName
        self.planetEnglishName = ""
        self.planetImage = planetImage
    }
    
    init(planetKoreanName: String, planetEnglishName: String, planetImage: UIImage?) {
        self.planetKoreanName = planetKoreanName
        self.planetEnglishName = planetEnglishName
        self.planetImage = planetImage
    }
}
