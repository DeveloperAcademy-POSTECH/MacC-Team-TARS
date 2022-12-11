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
                      planetTitle1: "태양에 도착하다",
                      planetContents1: "태양계에서 가장 중요한 별인 태양이군요. 지구에서 생명체가 살아가기 위한 열과 빛은 모두 태양으로부터 옵니다. 사실 우리가 지구에서 보는 햇빛은 8분 20초 전에 태양에서 나온 빛입니다. 흥미롭지 않나요? 그럼 지금부터 태양에 내려 자세히 알아봅시다.",
                      planetTitle2: "태양을 느끼다",
                      planetContents2: "자, 태양에 도착했습니다. 태양은 수소와 헬륨으로 이루어진 아주 커다란 가스 덩어리입니다. 온도가 너무 뜨거워서 고체와 액체 상태로 있을 수가 없지요. 태양은 너무 뜨겁고 밝기 때문에 지구에서 태양을 맨눈으로 바라볼 수 없는데, 태양의 중심은 15,700,000도까지 올라가기도 합니다.",
                      planetTitle3: "멀리서 느끼는 태양",
                      planetContents3: "이번엔 뜨거운 태양을 떠나 아주 멀리서 거대한 태양을 느껴봅시다. 태양 표면에 다른 영역과는 다르게 보이는 점들이 있습니다. 태양 하면 빼놓을 수 없는 흑점과 태양 플레어입니다. 핵융합으로 인해 태양에 에너지가 많이 쌓이면 이 에너지를 분출하게 되는데요, 펑! 하고 갑자기 표면 위로 터져 올라옵니다. 이 현상을 느끼기 위해서는 흑점 가까이에 있으면 됩니다."),
        PlanetContent(planetName: LocalizableStrings.moon,
                      planetTitle1: "달에 도착하다",
                      planetContents1: "지구의 유일한 위성 달에 도착했습니다. 화성만한 크기의 천체가 지구와 충돌해 만들어졌다고 생각되는 달은 지구와 비교했을 때 3.7배나 작습니다. 지구가 500원 동전의 크기라면 지구의 작은 동반자인 달은 완두콩 한 알과 비슷합니다. 달의 크기에 대해 느낌이 오셨나요? 그래도 달은 태양계에서 5번째로 큰 위성이랍니다. 지금부터 달을 여행해 볼까요?",
                      planetTitle2: "달의 바다",
                      planetContents2: "초기 천문학자들은 달 표면의 짙은 점을 달의 바다라고 생각해 라틴어로 바다를 뜻하는 마레라고 이름 붙였습니다. 이후 달의 바다는 화산 폭발로 만들어진 평원으로 지구의 바다와는 관련이 없다는 것이 밝혀졌지만 아직도 바다라고 불리고 있답니다. 달의 많은 바다 중 고요의 바다를 들러보세요. 처음으로 달에 착륙한 유인 우주선인 아폴로 11호가 착륙한 고요의 바다는 달에 오면 꼭 들려야 하는 필수 관광지입니다.",
                      planetTitle3: "먼저 다녀간 사람들",
                      planetContents3: "지구에서 가장 가까운 천체인 달은 인간이 지구 외에 방문한 유일한 천체입니다. 지금까지 105개가 넘는 무인 우주선이 달을 탐험하기 위해 발사됐고 12명의 사람이 달에 발을 디뎠습니다. 달의 표면에서 먼저 다녀간 사람의 흔적을 찾아보세요. 우주비행사들이 남긴 장비 조각들, 성조기, 카메라를 발견할 수 있고, 아폴로 11호의 우주 비행사가 남긴 발자국도 있답니다."),
        PlanetContent(planetName: LocalizableStrings.mercury,
                      planetTitle1: "수성 여행 준비물",
                      planetContents1: "태양과 거리가 가까워 매우 뜨거운 수성에 도착했습니다. 낮에는 179℃까지 올라가는 수성에서는 맨발로 땅을 밟지 않도록 조심해야 합니다. 신발을 꼭 챙겨가세요! 방열 기능이 뛰어난 우주복 또한 필수 준비물 입니다. 실수로 화상을 입더라도 너무 걱정하지 마세요. 이렇게 뜨거운 수성에도 태양 빛이 전혀 닿지 않는 극지방 깊은 분화구에는 얼음이 존재한답니다. 얼음 분화구로 가서 휴식을 취해볼까요?",
                      planetTitle2: "분지에서 하는 보물찾기",
                      planetContents2: "수성에는 얼음이 존재하는 분화구 말고도 아주 유명한 관광 분화구 명소가 하나 더 있습니다. 태양계 행성에 있는 분지 중 가장 커다란 크기를 자랑하는 칼로리스 분지입니다. 거대한 혜성의 충돌로 만들어진 이 분지는 한 가운데에서 거미 모양의 지형을 발견할 수 있다고 하니 한번 찾아보세요!",
                      planetTitle3: "아름다운 수성의 야경",
                      planetContents3: "수성을 아름다운 행성으로 만드는 핵심 포인트는 바로 밤하늘에 놓여있는 오로라입니다. 밤이 되면 수성에서는 나트륨 원자로 구성된 대기가 행성 전체를 금빛으로 물들입니다. 오직 수성에서만 찾아볼 수 있는 밤하늘을 마음속에 간직해보세요."),
        PlanetContent(planetName: LocalizableStrings.venus,
                      planetTitle1: "금성에 도착하다",
                      planetContents1: "태양 다음으로 가장 밝게 빛나는 행성을 따라가니 금성에 도착했습니다. 밤하늘에서 금빛으로 반짝이는 금성은 태양계에서 가장 아름다운 행성으로 여러 신화를 통해 미의 여신으로 불리고는 했습니다. 미의 여신을 생각하면서 금성을 여행해봅시다.",
                      planetTitle2: "금성의 두얼굴",
                      planetContents2: "아름다운 금성을 여행할 여러분들은 이제부터 단단히 각오하셔야 합니다. 금빛 아름다움 속에 날카로운 가시를 품고있기 때문입니다. 금성은 두껍고 밀도 높은 대기 때문에 극심한 온실 효과가 발생합니다. 실제로 금성의 표면 온도는 465℃까지 올라갑니다. 더위를 피할 수 있는 곳을 찾아 어서 들어갑시다.",
                      planetTitle3: "금성에서 시작하는 하루",
                      planetContents3: "더위를 피할 수 있는 곳에서 잠을 자고 일어나니 저 멀리 해가 뜨고 있습니다. 금성에서는 아주 특이한 자연현상을 만날 수 있는데요. 바로 해가 서쪽에서 뜨는 것입니다.  금성은 지구와 달리 시계방향으로 자전을 하기 때문인데요. 서쪽에서 뜨는 해는 얼마나 다를지 한번 느껴봅시다."),
        PlanetContent(planetName: LocalizableStrings.mars,
                      planetTitle1: LocalizableStrings.marsChapterOneTitle,
                      planetContents1: LocalizableStrings.marsChapterOneContent,
                      planetTitle2: LocalizableStrings.marsChapterTwoTitle,
                      planetContents2: LocalizableStrings.marsChapterTwoContent,
                      planetTitle3: LocalizableStrings.marsChapterThreeTitle,
                      planetContents3: LocalizableStrings.marsChapterThreeContent),
        PlanetContent(planetName: LocalizableStrings.jupiter,
                      planetTitle1: "목성에 도착하다",
                      planetContents1: "태양계에서 가장 크기가 큰 행성을 찾아오니 목성에 도착했습니다. 목성은 태양계에 있는 다른 모든 행성을 합친 것보다 두 배 이상 무겁고 반지름은 지구의 11배입니다. 지구가 포도라면 목성은 농구공 정도의 크기를 가지고 있답니다. 목성의 크기가 느껴지시나요? 이렇게 커다란 목성을 다 둘러보려면 서둘러서 움직여야겠네요.",
                      planetTitle2: "목성의 날씨",
                      planetContents2: "즐거운 여행을 위해 꼭 필요한 것은 맑은 날씨입니다. 하지만 목성에서는 강한 뇌우와 거대한 폭풍을 조심해야 합니다. 목성의 폭풍 대적점은 타원형의 반점 모습을 하고 있습니다. 지구의 두 배 넓이를 가지고 있는 이 거대하고 강력한 폭풍은 목성에서 150년 이상 소용돌이치고 있다고 하니 다들 조심하세요.",
                      planetTitle3: "위성으로 떠나는 여행",
                      planetContents3: "이번에는 목성의 얼음 위성 유로파로 출발해봅시다. 얼음으로 덮여있는 유로파에서 스케이트를 타보세요. 이 얼음 지각 밑에는 생명체가 살 수 있는 광대한 바다가 있다는 증거가 있어 과학자들의 관심을 받고 있습니다. 이 밖에도 넘치는 매력을 가지는 목성은 주변을 끌어당기는 자기장으로 주변 위성만 80개입니다. 다음은 어떤 위성으로 여행을 떠나볼까요?"),
        PlanetContent(planetName: LocalizableStrings.saturn,
                      planetTitle1: "크고 가벼운 토성",
                      planetContents1: "이번 도착지는 아름다운 토성입니다. 토성은 태양계에서 목성 다음으로 두 번째로 큰 행성입니다. 얼마나 크냐면 765개의 지구를 담을 수 있을 만큼 크답니다. 질량은 지구의 100배나 되고요! 하지만 밀도가 매우 낮아 토양에 착륙할 수는 없습니다. 착륙할 수 없어도 너무 아쉬워하지는 마세요! 토성에는 착륙하지 않고도 볼 수 있는 볼거리가 아주 많답니다.",
                      planetTitle2: "태양계의 보석",
                      planetContents2: "아름다운 고리를 가진 토성입니다. 멋진 고리를 가까이서 감상하는 것은 토성 여행의 가장 큰 매력 포인트 중 하나입니다. 하지만 고리를 손으로 만져볼 수는 없습니다. 고리는 수조 개의 아주 작은 크기 물질부터 바위 크기의 물질까지 토성 주위를 돌고 있기 때문입니다. 다치지 않게 조심하세요!",
                      planetTitle3: "타이탄의 강과 사막",
                      planetContents3: "이번엔 토양의 위성으로 여행을 떠나봅시다. 토성은 63개의 위성을 가지고 있는데 그 중 타이탄은 태양계의 다른 행성으로 보일 수 있을 정도로, 수성을 넘어서는 상당한 크기를 자랑합니다. 기온이 매우 낮으므로 메탄처럼 지구에서는 기체로 존재하는 가스들이 강물처럼 흐르고 있죠. 방한 기능이 충분한 우주복을 가져오셨나요? 차가운 메탄 강에서 우주복을 입고 함께 물놀이를 해봐요!"),
        PlanetContent(planetName: LocalizableStrings.uranus,
                      planetTitle1: "냄새나는 천왕성",
                      planetContents1: "천왕성 가까이 다가가니 어디서 많이 맡아본 이상한 냄새가 납니다. 천왕성 구름 상층부가 황화수소로 구성되어있기 때문인데요. 황화수소의 농도가 아주 짙어서 사람이 그 근처에 가면 질식할 정도입니다. 방독면을 잊지 말고 꼭 챙겨가세요!",
                      planetTitle2: "누워서 도는 행성",
                      planetContents2: "천왕성이 자전하는 모습을 바라보니 조금 이상합니다. 다른 행성과는 다르게 옆으로 누워서 자전하는데요. 지구의 자전축은 23.5° 인 반면 천왕성의 자전축은 97.77°로 90도 이상 기울어져 있습니다. 그러므로 다른 행성들은 옆으로 돌 때 천왕성만 혼자 옆구르기를 하는 것입니다. 천왕성에선 멀미를 할 수도 있겠군요.",
                      planetTitle3: "차갑고 거대한 얼음 행성",
                      planetContents3: "거대한 청록빛 천체인 천왕성은 해왕성과 함께 거대 얼음 행성으로 불립니다. 하지만 천왕성의 표면 중력은 지구보다 조금 더 약하기 때문에, 지구에서의 50kg는 천왕성에서 44kg가 된답니다. 천왕성의 지름은 지구의 4배 정도, 질량은 지구의 14배에 달하지만, 밀도가 태양계에서 토성 다음으로 낮기 때문에, 지구보다 약한 중력을 갖고 있어요. 천왕성이 태양을 중심으로 한바퀴를 도는 동안, 지구에서는 80년이 흐르게 됩니다. 인간의 삶으로 천왕성의 사계절은 어떻게 다가올까요? 많은 과학자들의 관심을 받고 있는 태양계 행성으로, 오랜 시간 미지의 행성으로 남은 천왕성의 다음 탐사 계획도 기대되는군요!"),
        PlanetContent(planetName: LocalizableStrings.neptune,
                      planetTitle1: "멀고 먼 해왕성",
                      planetContents1: "태양계의 8번째 행성이자 태양으로부터 가장 멀리 떨어진 해왕성으로 출발합니다. 해왕성은 지구와 아주 멀리 떨어져 있어 해왕성을 방문한 유일한 우주선인 보이저 2호는 해왕성에 도착하기까지 무려 12년이 걸렸습니다. 우리 함께 길고 긴 해왕성으로의 여행을 떠나봅시다.",
                      planetTitle2: "해왕성 고리의 비밀",
                      planetContents2: "사실 해왕성은 토성처럼 행성의 고리를 갖고 있습니다. 5개의 고리가 해왕성을 감싸고 있지만 아쉽게도 대부분의 고리는 아주 얇고 희미해 토성처럼 잘 보이지는 않습니다. 조금 더 가까이 다가가 해왕성의 고리를 찾아봅시다.",
                      planetTitle3: "거대한 바닷속 보물",
                      planetContents3: "해왕성 바다에는 다이아몬드가 둥둥 떠다니는 다이아몬드 바다가 있습니다. 내핵이 액화된 다이아몬드로 존재하는데 남극 빙산보다도 더 거대한 다이아몬드 덩어리를 찾아볼 수 있습니다. 그럼 다이아몬드를 찾으러 해왕성 내부로 떠나볼까요?")
    ]
}
