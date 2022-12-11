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
    static let chapterOneHint = NSLocalizedString("총 3 chapter 중에서 chapter 1", comment: "")
    static let chapterTwoHint = NSLocalizedString("총 3 chapter 중에서 chapter 2", comment: "")
    static let chapterThreeHint = NSLocalizedString("총 3 chapter 중에서 chapter 3", comment: "")
    

    
    // MARK: Contents
    static let sunChapterOneTitle = NSLocalizedString("sunChapterOneTitle", comment: "")
    static let sunChapterOneContent = NSLocalizedString("sunChapterOneContent", comment: "")
    static let sunChapterTwoTitle = NSLocalizedString("sunChapterTwoTitle", comment: "")
    static let sunChapterTwoContent = NSLocalizedString("sunChapterTwoContent", comment: "")
    static let sunChapterThreeTitle = NSLocalizedString("sunChapterThreeTitle", comment: "")
    static let sunChapterThreeContent = NSLocalizedString("sunChapterThreeContent", comment: "")
    
    static let moonChapterOneTitle = NSLocalizedString("moonChapterOneTitle", comment: "")
    static let moonChapterOneContent = NSLocalizedString("moonChapterOneContent", comment: "")
    static let moonChapterTwoTitle = NSLocalizedString("moonChapterTwoTitle", comment: "")
    static let moonChapterTwoContent = NSLocalizedString("moonChapterTwoContent", comment: "")
    static let moonChapterThreeTitle = NSLocalizedString("moonChapterThreeTitle", comment: "")
    static let moonChapterThreeContent = NSLocalizedString("moonChapterThreeContent", comment: "")
    
    static let mercuryChapterOneTitle = NSLocalizedString("mercuryChapterOneTitle", comment: "")
    static let mercuryChapterOneContent = NSLocalizedString("mercuryChapterOneContent", comment: "")
    static let mercuryChapterTwoTitle = NSLocalizedString("mercuryChapterTwoTitle", comment: "")
    static let mercuryChapterTwoContent = NSLocalizedString("mercuryChapterTwoContent", comment: "")
    static let mercuryChapterThreeTitle = NSLocalizedString("mercuryChapterThreeTitle", comment: "")
    static let mercuryChapterThreeContent = NSLocalizedString("mercuryChapterThreeContent", comment: "")
    
    static let venusChapterOneTitle = NSLocalizedString("venusChapterOneTitle", comment: "")
    static let venusChapterOneContent = NSLocalizedString("venusChapterOneContent", comment: "")
    static let venusChapterTwoTitle = NSLocalizedString("venusChapterTwoTitle", comment: "")
    static let venusChapterTwoContent = NSLocalizedString("venusChapterTwoContent", comment: "")
    static let venusChapterThreeTitle = NSLocalizedString("venusChapterThreeTitle", comment: "")
    static let venusChapterThreeContent = NSLocalizedString("venusChapterThreeContent", comment: "")

    static let marsChapterOneTitle = NSLocalizedString("marsChapterOneTitle", comment: "")
    static let marsChapterOneContent = NSLocalizedString("marsChapterOneContent", comment: "")
    static let marsChapterTwoTitle = NSLocalizedString("marsChapterTwoTitle", comment: "")
    static let marsChapterTwoContent = NSLocalizedString("marsChapterTwoContent", comment: "")
    static let marsChapterThreeTitle = NSLocalizedString("marsChapterThreeTitle", comment: "")
    static let marsChapterThreeContent = NSLocalizedString("marsChapterThreeContent", comment: "")
    
    static let jupiterChapterOneTitle = NSLocalizedString("jupiterChapterOneTitle", comment: "")
    static let jupiterChapterOneContent = NSLocalizedString("jupiterChapterOneContent", comment: "")
    static let jupiterChapterTwoTitle = NSLocalizedString("jupiterChapterTwoTitle", comment: "")
    static let jupiterChapterTwoContent = NSLocalizedString("jupiterChapterTwoContent", comment: "")
    static let jupiterChapterThreeTitle = NSLocalizedString("jupiterChapterThreeTitle", comment: "")
    static let jupiterChapterThreeContent = NSLocalizedString("jupiterChapterThreeContent", comment: "")
    
    static let saturnChapterOneTitle = NSLocalizedString("saturnChapterOneTitle", comment: "")
    static let saturnChapterOneContent = NSLocalizedString("saturnChapterOneContent", comment: "")
    static let saturnChapterTwoTitle = NSLocalizedString("saturnChapterTwoTitle", comment: "")
    static let saturnChapterTwoContent = NSLocalizedString("saturnChapterTwoContent", comment: "")
    static let saturnChapterThreeTitle = NSLocalizedString("saturnChapterThreeTitle", comment: "")
    static let saturnChapterThreeContent = NSLocalizedString("saturnChapterThreeContent", comment: "")
    
    static let uranusChapterOneTitle = NSLocalizedString("uranusChapterOneTitle", comment: "")
    static let uranusChapterOneContent = NSLocalizedString("uranusChapterOneContent", comment: "")
    static let uranusChapterTwoTitle = NSLocalizedString("uranusChapterTwoTitle", comment: "")
    static let uranusChapterTwoContent = NSLocalizedString("uranusChapterTwoContent", comment: "")
    static let uranusChapterThreeTitle = NSLocalizedString("uranusChapterThreeTitle", comment: "")
    static let uranusChapterThreeContent = NSLocalizedString("uranusChapterThreeContent", comment: "")
    
    static let neptuneChapterOneTitle = NSLocalizedString("neptuneChapterOneTitle", comment: "")
    static let neptuneChapterOneContent = NSLocalizedString("neptuneChapterOneContent", comment: "")
    static let neptuneChapterTwoTitle = NSLocalizedString("neptuneChapterTwoTitle", comment: "")
    static let neptuneChapterTwoContent = NSLocalizedString("neptuneChapterTwoContent", comment: "")
    static let neptuneChapterThreeTitle = NSLocalizedString("neptuneChapterThreeTitle", comment: "")
    static let neptuneChapterThreeContent = NSLocalizedString("neptuneChapterThreeContent", comment: "")
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
