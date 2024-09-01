//
//  LocalizableKeys.swift
//  Tars
//
//  Created by Lena on 12/07/2024.
//

import Foundation

enum LocalizableKeys: String {
    case sun, moon, mercury, venus, mars, jupiter, saturn, uranus, neptune
    case airPodsInstructionstring, onboardingInstructionstring, onboardingInstructionTitle
    case collectionViewTitle, collectionViewContent
    
    case exploreUniverseNavigationTitle, searchingNavigationTitle
    case directionUp, directionUpRight, directionRight, directionDownRight, directionDown, directionDownLeft, directionLeft, directionUpLeft
    case locationUsageMessage, locationAuthRequest, defaultAction, cancel
    case networkTitle, networkUsageMessage
    
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
    
    /// 문자 형태의 string을 LocalizableKeys의 열거형으로 변환
    init?(from string: String) {
        self.init(rawValue: string)
    }
    
    /// LocalizableKeys의 값을  시스템 언어로 localize
    var localized: String {
        return self.rawValue.localized()
    }
    
    /// 원하는 언어로 localize
    /// - Parameter language: .english / .korean 중 선택
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
