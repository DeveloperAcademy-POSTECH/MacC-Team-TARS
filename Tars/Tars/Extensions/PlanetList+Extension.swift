//
//  PlanetList+Extension.swift
//  Tars
//
//  Created by 김소현 on 2022/11/01.
//

import UIKit

let planetList: [Planet] = [
    Planet(planetName: "태양", planetImage: UIImage(named: "Sun")),
    Planet(planetName: "달", planetImage: UIImage(named: "Moon")),
    Planet(planetName: "수성", planetImage: UIImage(named: "Mercury")),
    Planet(planetName: "금성", planetImage: UIImage(named: "Venus")),
    Planet(planetName: "화성", planetImage: UIImage(named: "Mars")),
    Planet(planetName: "목성", planetImage: UIImage(named: "Jupiter")),
    Planet(planetName: "토성", planetImage: UIImage(named: "Saturn")),
    Planet(planetName: "천왕성", planetImage: UIImage(named: "Uranus")),
    Planet(planetName: "해왕성", planetImage: UIImage(named: "Neptune"))
]

let planetNames: [String] = ["Sun", "Moon", "Mercury", "Venus", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
let planetNameDict: [String: String] = ["Sun": "태양", "Moon": "달", "Mercury": "수성", "Venus": "금성", "Mars": "화성", "Jupiter": "목성", "Saturn": "토성", "Uranus": "천왕성", "Neptune": "해왕성"]
