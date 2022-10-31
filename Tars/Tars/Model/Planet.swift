//
//  Planet.swift
//  Tars
//
//  Created by 김소현 on 2022/10/25.
//

import UIKit

struct Planet {
    let planetName: String
    let planetImage: UIImage?
    
    init(planetName: String, planetImage: UIImage?) {
        self.planetName = planetName
        self.planetImage = planetImage
    }
}
