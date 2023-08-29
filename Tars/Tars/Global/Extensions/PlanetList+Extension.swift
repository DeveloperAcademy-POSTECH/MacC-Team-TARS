//
//  PlanetList+Extension.swift
//  Tars
//
//  Created by 김소현 on 2022/11/01.
//

import UIKit

let planetList: [Planet] = [
    Planet(planetKoreanName: LocalizableStrings.sun, planetImage: UIImage(named: "Sun")),
    Planet(planetKoreanName: LocalizableStrings.moon, planetImage: UIImage(named: "Moon")),
    Planet(planetKoreanName: LocalizableStrings.mercury, planetImage: UIImage(named: "Mercury")),
    Planet(planetKoreanName: LocalizableStrings.venus, planetImage: UIImage(named: "Venus")),
    Planet(planetKoreanName: LocalizableStrings.mars, planetImage: UIImage(named: "Mars")),
    Planet(planetKoreanName: LocalizableStrings.jupiter, planetImage: UIImage(named: "Jupiter")),
    Planet(planetKoreanName: LocalizableStrings.saturn, planetImage: UIImage(named: "Saturn")),
    Planet(planetKoreanName: LocalizableStrings.uranus, planetImage: UIImage(named: "Uranus")),
    Planet(planetKoreanName: LocalizableStrings.neptune, planetImage: UIImage(named: "Neptune"))
]

let planetEnglishNames: [String] = ["Sun", "Moon", "Mercury", "Venus", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

let planetNameDict: [String: String] = ["Sun": LocalizableStrings.sun, "Moon": LocalizableStrings.moon, "Mercury": LocalizableStrings.mercury, "Venus": LocalizableStrings.venus, "Mars": LocalizableStrings.mars, "Jupiter": LocalizableStrings.jupiter, "Saturn": LocalizableStrings.saturn, "Uranus": LocalizableStrings.uranus, "Neptune": LocalizableStrings.neptune]

extension PlanetContent {
    static let planetContentsList: [PlanetContent] = [
        PlanetContent(planetName: LocalizableStrings.sun,
                      planetTitle1: LocalizableStrings.sunChapterOneTitle,
                      planetContents1: LocalizableStrings.sunChapterOneContent,
                      planetTitle2: LocalizableStrings.sunChapterTwoTitle,
                      planetContents2: LocalizableStrings.sunChapterTwoContent,
                      planetTitle3: LocalizableStrings.sunChapterThreeTitle,
                      planetContents3: LocalizableStrings.sunChapterThreeContent),
        PlanetContent(planetName: LocalizableStrings.moon,
                      planetTitle1: LocalizableStrings.moonChapterOneTitle,
                      planetContents1: LocalizableStrings.moonChapterOneContent,
                      planetTitle2: LocalizableStrings.moonChapterTwoTitle,
                      planetContents2: LocalizableStrings.moonChapterTwoContent,
                      planetTitle3: LocalizableStrings.moonChapterThreeTitle,
                      planetContents3: LocalizableStrings.moonChapterThreeContent),
        PlanetContent(planetName: LocalizableStrings.mercury,
                      planetTitle1: LocalizableStrings.mercuryChapterOneTitle,
                      planetContents1: LocalizableStrings.mercuryChapterOneContent,
                      planetTitle2: LocalizableStrings.mercuryChapterTwoTitle,
                      planetContents2: LocalizableStrings.mercuryChapterTwoContent,
                      planetTitle3: LocalizableStrings.mercuryChapterThreeTitle,
                      planetContents3: LocalizableStrings.mercuryChapterThreeContent),
        PlanetContent(planetName: LocalizableStrings.venus,
                      planetTitle1: LocalizableStrings.venusChapterOneTitle,
                      planetContents1: LocalizableStrings.venusChapterOneContent,
                      planetTitle2: LocalizableStrings.venusChapterTwoTitle,
                      planetContents2: LocalizableStrings.venusChapterTwoContent,
                      planetTitle3: LocalizableStrings.venusChapterThreeTitle,
                      planetContents3: LocalizableStrings.venusChapterThreeContent),
        PlanetContent(planetName: LocalizableStrings.mars,
                      planetTitle1: LocalizableStrings.marsChapterOneTitle,
                      planetContents1: LocalizableStrings.marsChapterOneContent,
                      planetTitle2: LocalizableStrings.marsChapterTwoTitle,
                      planetContents2: LocalizableStrings.marsChapterTwoContent,
                      planetTitle3: LocalizableStrings.marsChapterThreeTitle,
                      planetContents3: LocalizableStrings.marsChapterThreeContent),
        PlanetContent(planetName: LocalizableStrings.jupiter,
                      planetTitle1: LocalizableStrings.jupiterChapterOneTitle,
                      planetContents1: LocalizableStrings.jupiterChapterOneContent,
                      planetTitle2: LocalizableStrings.jupiterChapterTwoTitle,
                      planetContents2: LocalizableStrings.jupiterChapterTwoContent,
                      planetTitle3: LocalizableStrings.jupiterChapterThreeTitle,
                      planetContents3: LocalizableStrings.jupiterChapterThreeContent),
        PlanetContent(planetName: LocalizableStrings.saturn,
                      planetTitle1: LocalizableStrings.saturnChapterOneTitle,
                      planetContents1: LocalizableStrings.saturnChapterOneContent,
                      planetTitle2: LocalizableStrings.saturnChapterTwoTitle,
                      planetContents2: LocalizableStrings.saturnChapterTwoContent,
                      planetTitle3: LocalizableStrings.saturnChapterThreeTitle,
                      planetContents3: LocalizableStrings.saturnChapterThreeContent),
        PlanetContent(planetName: LocalizableStrings.uranus,
                      planetTitle1: LocalizableStrings.uranusChapterOneTitle,
                      planetContents1: LocalizableStrings.uranusChapterOneContent,
                      planetTitle2: LocalizableStrings.uranusChapterTwoTitle,
                      planetContents2: LocalizableStrings.uranusChapterTwoContent,
                      planetTitle3: LocalizableStrings.uranusChapterThreeTitle,
                      planetContents3: LocalizableStrings.uranusChapterThreeContent),
        PlanetContent(planetName: LocalizableStrings.neptune,
                      planetTitle1: LocalizableStrings.neptuneChapterOneTitle,
                      planetContents1: LocalizableStrings.neptuneChapterOneContent,
                      planetTitle2: LocalizableStrings.neptuneChapterTwoTitle,
                      planetContents2: LocalizableStrings.neptuneChapterTwoContent,
                      planetTitle3: LocalizableStrings.neptuneChapterThreeTitle,
                      planetContents3: LocalizableStrings.neptuneChapterThreeContent)
        ]
}
