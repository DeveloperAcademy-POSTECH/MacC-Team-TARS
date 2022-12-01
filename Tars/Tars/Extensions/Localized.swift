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
    static let marsChapterOneTitle = NSLocalizedString("화성에 도착하다", comment: "")
    static let marsChapterOneContent = NSLocalizedString("지구에서 58,000km/h로 달리는 가장 빠른 우주선을 타고 이동하니 39일만에 저 멀리 화성이 보입니다. 화성의 표면은 주로 울퉁불퉁한 현무암으로 구성되어 있고 토양에 산화철이 널리 퍼져 있어 붉은색을 띄고 있네요.", comment: "")
    static let marsChapterTwoTitle = NSLocalizedString("화성을 관광하다", comment: "")
    static let marsChapterTwoContent = NSLocalizedString("드디어 화성에 내렸습니다. 이번 여행은 화성의 다이나믹한 지형을 즐기는 산악여행입니다. 저기 웅장한 마리너 계곡이 있습니다. 마리너 계곡은 길이 4,023km, 깊이 10km에 달하는 태양계에서 가장 큰 골짜기로 그 크기만으로도 압도적인 화성의 필수 산악 코스입니다. 이러한 지형은 과거 엄청난 양의 물이 흐르면서 형성된 것으로, 그 수량은 아마존강의 2백 배 이상으로 추정되고 있습니다.", comment: "")
    static let marsChapterThreeTitle = NSLocalizedString("여행의 마무리", comment: "")
    static let marsChapterThreeContent = NSLocalizedString("드디어 일몰의 시간입니다. 마리너 계곡의 풍경 좋은 곳에 자리를 잡고 앉아 일몰을 관찰합니다. 지평선 너머 푸른빛의 노을을 볼 수 잇습니다. 화성의 붉은 먼지들이 햇빛을 산란시켜 낮에는 붉고 해질녘에는 파랗게 보이는 것입니다. 멋진 일몰을 보며 화성에서의 하루가 마무리됩니다.", comment: "")
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
