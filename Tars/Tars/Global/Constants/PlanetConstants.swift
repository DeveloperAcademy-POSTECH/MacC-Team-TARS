//
//  PlanetConstants.swift
//  Tars
//
//  Created by Lena on 2024/7/11.
//

import Foundation

enum Planet: String, CaseIterable {
    case sun
    case moon
    case mercury
    case venus
    case mars
    case jupiter
    case saturn
    case uranus
    case neptune
}

// MARK: - Localization
extension Planet {
    /// 문자열을 열거형으로 변환
    init?(from string: String) {
        self.init(rawValue: string)
    }
    
    /// 시스템 언어에 따라 localized 된 행성이름
    var planetName: String {
        return self.rawValue.localized()
    }
    
    /// 영어로 localized된 행성이름
    var nameEnglish: String {
        return self.rawValue.localized(for: .english)
    }
    
    /// 한글로 localized된 행성이름
    var nameKorean: String {
        return self.rawValue.localized(for: .korean)
    }
    
    /// String 값을 받아 이를 Planet 중 해당 행성의 case 를 찾아, 이를 다시 localized된 행성 이름
    static func localizedName(for name: String) -> String {
        if let planet = Planet(from: name) {
            return planet.planetName
        }
        return name
    }
    
    /// 모든 행성들의 배열 (.en, .ko, systemLanguage)
    static func allPlanetNames(in language: Language? = nil) -> [String] {
        return self.allCases.map { planet in
            switch language {
            case .english:
                return planet.nameEnglish
            case .korean:
                return planet.nameKorean
            default:
                return planet.planetName
            }
        }
    }
}

// MARK: - Planet Contents
extension Planet {
    /// LocalizableKeys와 매핑하여 해당 key를 가진 프로퍼티
    private var chapterKeys: [Chapter] {
        return ["One", "Two", "Three"].map {
            Chapter(titleKey: "\(self.rawValue)Chapter\($0)Title",
                    contentKey: "\(self.rawValue)Chapter\($0)Content")
        }
    }
    
    /// 매핑 후 실제 value를 가진 프로퍼티
    var titlesAndContents: [(String, String)] {
        return chapterKeys.map { chapter in
            let titleKey = chapter.titleKey
            let contentKey = chapter.contentKey
            return (titleKey, contentKey)
        }
    }
}

struct Chapter {
    let titleKey: String
    let contentKey: String
}

struct PlanetConstants {
    static let planetsKo = Planet.allPlanetNames(in: .korean)
    static let planetsEn = Planet.allPlanetNames(in: .english)
    static let planetsSystem = Planet.allPlanetNames()
}
