//
//  PlanetList+Extension.swift
//  Tars
//
//  Created by 김소현 on 2022/11/01.
//

import UIKit

let planetList: [Planet] = [
    Planet(planetKoreanName: "태양", planetImage: UIImage(named: "Sun")),
    Planet(planetKoreanName: "달", planetImage: UIImage(named: "Moon")),
    Planet(planetKoreanName: "수성", planetImage: UIImage(named: "Mercury")),
    Planet(planetKoreanName: "금성", planetImage: UIImage(named: "Venus")),
    Planet(planetKoreanName: "화성", planetImage: UIImage(named: "Mars")),
    Planet(planetKoreanName: "목성", planetImage: UIImage(named: "Jupiter")),
    Planet(planetKoreanName: "토성", planetImage: UIImage(named: "Saturn")),
    Planet(planetKoreanName: "천왕성", planetImage: UIImage(named: "Uranus")),
    Planet(planetKoreanName: "해왕성", planetImage: UIImage(named: "Neptune"))
]

let planetEnglishNames: [String] = ["Sun", "Moon", "Mercury", "Venus", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

let planetNameDict: [String: String] = ["Sun": "태양", "Moon": "달", "Mercury": "수성", "Venus": "금성", "Mars": "화성", "Jupiter": "목성", "Saturn": "토성", "Uranus": "천왕성", "Neptune": "해왕성"]
