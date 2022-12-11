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
    static let onboardingInstructionTitle = NSLocalizedString("AR기능 사용을 위해 주변 스캔이 필요합니다. \n아이폰을 좌우, 아래 위로 움직여 주변을 스캔하세요.", comment: "")
    
    // MARK: CollectionView
    
    static let collectionViewTitle = NSLocalizedString("빠르게 천체 찾기", comment: "")
    static let collectionViewContent = NSLocalizedString("찾고싶은 천체를 선택해보세요", comment: "")
    static let exploreUniverseNavigationTitle = NSLocalizedString("우주 둘러보기", comment: "")
    static let searchingNavigationTitle = NSLocalizedString("천체 찾는 중", comment: "")
    
    // MARK: Direction
    
    static let directionUp = NSLocalizedString("위로 이동하세요", comment: "")
    static let directionUpRight = NSLocalizedString("오른쪽 위로 이동하세요", comment: "")
    static let directionRight = NSLocalizedString("오른쪽으로 이동하세요", comment: "")
    static let directionDownRight = NSLocalizedString("오른쪽 아래로 이동하세요", comment: "")
    static let directionDown = NSLocalizedString("아래로 이동하세요", comment: "")
    static let directionDownLeft = NSLocalizedString("왼쪽 아래로 이동하세요", comment: "")
    static let directionLeft = NSLocalizedString("왼쪽으로 이동하세요", comment: "")
    static let directionUpLeft = NSLocalizedString("왼쪽 위로 이동하세요", comment: "")
    
    // MARK: Components
    static let image = NSLocalizedString("이미지", comment: "")
    
    // MARK: Contents
    static let marsChapterOneTitle = NSLocalizedString("화성에 도착하다", comment: "")
    static let marsChapterOneContent = NSLocalizedString("지구에서 가장 빠른 우주선을 타고 이동하니 39일 만에 화성에 도착했습니다. 화성의 표면은 현무암으로 구성되어 있어 울퉁불퉁하네요. 넘어지지 않게 조심해야겠습니다.", comment: "")
    static let marsChapterTwoTitle = NSLocalizedString("화성을 관광하다", comment: "")
    static let marsChapterTwoContent = NSLocalizedString("이번 여행은 화성의 다이나믹한 지형을 즐기는 산악여행입니다. 저기 웅장한 마리너 계곡이 있습니다. 마리너 계곡의 길이는 그랜드 캐니언의 10배에 달하고 깊이는 3배나 되는 태양계에서 가장 큰 골짜기입니다. 화성 필수 산악 코스인 마리너 계곡을 등산해봅시다.", comment: "")
    static let marsChapterThreeTitle = NSLocalizedString("마리너 계곡에서의 휴식", comment: "")
    static let marsChapterThreeContent = NSLocalizedString("웅장한 마리너 계곡을 등산하다 보니 목이 마르지 않으신가요? 하지만 걱정하지 마세요. 마리너 계곡 중앙부의 물질은 40%가 물로 추정됩니다. 계곡의 중앙에 도착할 때까지 조금만 힘내보세요!", comment: "")
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
