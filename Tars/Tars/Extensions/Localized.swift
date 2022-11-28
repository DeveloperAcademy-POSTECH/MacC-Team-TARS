//
//  localized.swift
//  Tars
//
//  Created by Seik Oh on 06/11/2022.
//

import Foundation

struct LocalizableStrings {
    
    // MARK: Planets
    
    static let sun  = NSLocalizedString("태양", comment: "")
    static let moon  = NSLocalizedString("달", comment: "")
    static let mercury  = NSLocalizedString("수성", comment: "")
    static let venus  = NSLocalizedString("금성", comment: "")
    static let mars  = NSLocalizedString("화성", comment: "")
    static let jupiter  = NSLocalizedString("목성", comment: "")
    static let saturn  = NSLocalizedString("토성", comment: "")
    static let uranus  = NSLocalizedString("천왕성", comment: "")
    static let neptune  = NSLocalizedString("해왕성", comment: "")

    // MARK: Contents
    
    static let jupiterContent = NSLocalizedString("목성은 태양계의 다섯번째 행성이자 가장 큰 행성이다. 태양의 질량의 1,000분의 1배에 달하는 거대행성으로, 태양계에 있는 다른 모든 행성들을 합한 질량의 약 2.5배에 이른다", comment: "")
    
    // MARK: Onboarding
    
    static let airPodsInstructionstring = NSLocalizedString("몰입감 있게 우주를 경험하려면 에어팟을 꼭 착용해주세요", comment: "")
    static let onboardingInstructionstring = NSLocalizedString("팔을 뻗어 아이폰 카메라를 정면으로 향하게 하고 주변을 스캔하듯 아이폰을 움직이세요. 이제부터 우주탐색뷰로 넘어갑니다.", comment: "")
    static let onboardingInstructionTitle = NSLocalizedString("아이폰을 움직여 주변을 스캔하세요", comment: "")
    
    // MARK: CollectionView
    
    static let collectionViewTitle = NSLocalizedString("빠르게 천체 찾기", comment: "")
    static let collectionViewContent = NSLocalizedString("찾고싶은 천체를 선택해보세요", comment: "")
    static let exploreUniverseNavigationTitle = NSLocalizedString("우주 둘러보기", comment: "")
    static let searchingNavigationTitle = NSLocalizedString("천체 찾는 중", comment: "")
    
    // MARK: Direction
    
    static let directionUp = NSLocalizedString("위로", comment: "")
    static let directionUpRight = NSLocalizedString("오른쪽 위로", comment: "")
    static let directionRight = NSLocalizedString("오른쪽으로", comment: "")
    static let directionDownRight = NSLocalizedString("오른쪽 아래로", comment: "")
    static let directionDown = NSLocalizedString("아래로", comment: "")
    static let directionDownLeft = NSLocalizedString("왼쪽 아래로", comment: "")
    static let directionLeft = NSLocalizedString("왼쪽으로", comment: "")
    static let directionUpLeft = NSLocalizedString("왼쪽 위로", comment: "")
    
}

enum PlanetStrings: String {
    case jupiter, jupiterContent, airPodsInstructionstring, onboardingInstructionstring, onboardingInstructionTitle
    
    var localizedKey: String {
        switch self {
        case .jupiter:
            return LocalizableStrings.jupiter
        case .jupiterContent:
            return LocalizableStrings.jupiterContent
        case .airPodsInstructionstring:
            return LocalizableStrings.airPodsInstructionstring
        case .onboardingInstructionstring:
            return LocalizableStrings.onboardingInstructionstring
        case .onboardingInstructionTitle:
            return LocalizableStrings.onboardingInstructionTitle
        }
    }
}
