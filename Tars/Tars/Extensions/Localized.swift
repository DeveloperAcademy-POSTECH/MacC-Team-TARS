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
    
    static let airPodsInstructionstring = NSLocalizedString("제대로 우주 공간을 경험하기 위해서는 반드시 에어팟을 착용해주세요", comment: "")
    static let onboardingInstructionstring = NSLocalizedString("아이폰 카메마를 정면으로 향하게 하고 머리를 움직이듯이 아이폰을 주변을 스캔하듯 움직이세요", comment: "")
}

enum PlanetStrings: String {
    case jupiter, jupiterContent, airPodsInstructionstring, onboardingInstructionstring
    
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
        }
    }
}
