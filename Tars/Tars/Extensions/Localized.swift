//
//  localized.swift
//  Tars
//
//  Created by Seik Oh on 06/11/2022.
//

import Foundation

struct LocalizableStrings {
    static let jupiter  = NSLocalizedString("목성", comment: "")
    static let jupiterContent = NSLocalizedString("목성은 태양계의 다섯번째 행성이자 가장 큰 행성이다. 태양의 질량의 1,000분의 1배에 달하는 거대행성으로, 태양계에 있는 다른 모든 행성들을 합한 질량의 약 2.5배에 이른다", comment: "")
    
    static let airPodsInstructionstring = NSLocalizedString("몰입감 있게 우주를 경험하려면 에어팟을 꼭 착용해주세요", comment: "")
    static let onboardingInstructionstring = NSLocalizedString("팔을 뻗어 아이폰 카메라를 정면으로 향하게 하고 주변을 스캔하듯 아이폰을 움직이세요. 이제부터 우주탐색뷰로 넘어갑니다.", comment: "")
    static let onboardingInstructionTitle = NSLocalizedString("아이폰을 움직여 주변을 스캔하세요", comment: "")
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
