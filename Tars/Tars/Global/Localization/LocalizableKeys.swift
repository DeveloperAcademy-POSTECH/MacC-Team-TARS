//
//  localized.swift
//  Tars
//
//  Created by Seik Oh on 06/11/2022.
//

import Foundation

enum LocalizableKeys: String {
    case sun, moon, mercury, venus, mars, jupiter, saturn, uranus, neptune
    case airPodsInstructionstring, onboardingInstructionstring, onboardingInstructionTitle
    case collectionViewTitle, collectionViewContent
    case exploreUniverseNavigationTitle, searchingNavigationTitle
    case directionUp, directionUpRight, directionRight, directionDownRight, directionDown, directionDownLeft, directionLeft, directionUpLeft
    case image
    case chapterOneHint, chapterTwoHint, chapterThreeHint
    case sunChapterOneTitle, sunChapterOneContent, sunChapterTwoTitle, sunChapterTwoContent, sunChapterThreeTitle, sunChapterThreeContent
    case moonChapterOneTitle, moonChapterOneContent, moonChapterTwoTitle, moonChapterTwoContent, moonChapterThreeTitle, moonChapterThreeContent
    case mercuryChapterOneTitle, mercuryChapterOneContent, mercuryChapterTwoTitle, mercuryChapterTwoContent, mercuryChapterThreeTitle, mercuryChapterThreeContent
    case venusChapterOneTitle, venusChapterOneContent, venusChapterTwoTitle, venusChapterTwoContent, venusChapterThreeTitle, venusChapterThreeContent
    case marsChapterOneTitle, marsChapterOneContent, marsChapterTwoTitle, marsChapterTwoContent, marsChapterThreeTitle, marsChapterThreeContent
    case jupiterChapterOneTitle, jupiterChapterOneContent, jupiterChapterTwoTitle, jupiterChapterTwoContent, jupiterChapterThreeTitle, jupiterChapterThreeContent
    case saturnChapterOneTitle, saturnChapterOneContent, saturnChapterTwoTitle, saturnChapterTwoContent, saturnChapterThreeTitle, saturnChapterThreeContent
    case uranusChapterOneTitle, uranusChapterOneContent, uranusChapterTwoTitle, uranusChapterTwoContent, uranusChapterThreeTitle, uranusChapterThreeContent
    case neptuneChapterOneTitle, neptuneChapterOneContent, neptuneChapterTwoTitle, neptuneChapterTwoContent, neptuneChapterThreeTitle, neptuneChapterThreeContent
    
    var localized: String {
        return self.rawValue.localized()
    }
    
    func localized(for language: Language) -> String {
        return self.rawValue.localized(for: language)
    }
}

enum Language: String {
    case korean = "ko"
    case english = "en"

    var locale: Locale {
        return Locale(identifier: self.rawValue)
    }
}
