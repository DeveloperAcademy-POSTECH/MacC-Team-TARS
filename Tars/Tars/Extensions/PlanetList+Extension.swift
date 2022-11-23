//
//  PlanetList+Extension.swift
//  Tars
//
//  Created by 김소현 on 2022/11/01.
//

import UIKit

let planetList: [Planet] = [
    Planet(planetKoreanName: "태양", planetImage: UIImage(named: "Sun")),
    Planet(planetKoreanName: "달", planetImage: UIImage(named: "Moon")),
    Planet(planetKoreanName: "수성", planetImage: UIImage(named: "Mercury")),
    Planet(planetKoreanName: "금성", planetImage: UIImage(named: "Venus")),
    Planet(planetKoreanName: "화성", planetImage: UIImage(named: "Mars")),
    Planet(planetKoreanName: "목성", planetImage: UIImage(named: "Jupiter")),
    Planet(planetKoreanName: "토성", planetImage: UIImage(named: "Saturn")),
    Planet(planetKoreanName: "천왕성", planetImage: UIImage(named: "Uranus")),
    Planet(planetKoreanName: "해왕성", planetImage: UIImage(named: "Neptune"))
]

let planetEnglishNames: [String] = ["Sun", "Moon", "Mercury", "Venus", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

let planetNameDict: [String: String] = ["Sun": "태양", "Moon": "달", "Mercury": "수성", "Venus": "금성", "Mars": "화성", "Jupiter": "목성", "Saturn": "토성", "Uranus": "천왕성", "Neptune": "해왕성"]

let planetContentsList: [PlanetContentsList] = [
    PlanetContentsList(planetName: "태양",
                       planetInfoFirstTitle: "태양에 도착하다",
                       planetInfoFirstContents: "태양계에서 가장 중요한 별인 태양이군요. 지구에서 생명체가 살아가기 위한 열과 빛은 모두 태양으로부터 옵니다. 사실 우리가 지구에서 보는 햇빛은 8분20초 전에 태양에서 나온 빛입니다. 흥미롭지 않나요? 그럼 지금부터 태양에 내려 자세히 알아봅시다.",
                       planetInfoSecondTitle: "태양을 느끼다",
                       planetInfoSecondContents: "자, 태양에 도착을 했습니다. 태양은 수소와 헬륨으로 이루어진 아주 커다란 가스 덩어리입니다. 온도가 너무 뜨거워서 고체와 액체 상태로 있을 수가 없지요. 태양은 너무 뜨겁고 밝기 때문에 지구에서 태양을 맨눈으로 바라볼 수 없는데, 태양의 중심은 15,700,000도까지 올라가기도 합니다.",
                       planetInfoLastTitle: "멀리서 바라본 태양",
                       planetInfoLastContents: "이번엔 뜨거운 태양을 떠나 아주 멀리서 거대한 태양을 바라봅시다. 태양 표면에 다른 영역보다 유독 검은색으로 보이는 점들이 있습니다. 태양하면 빼놓을 수 없는 흑점과 태양 플레어입니다. 핵융합으로 인해 태양에 에너지가 많이 쌓이면 이 에너지를 분출하게 되는데요, 펑!하고 갑자기 표면 위로 터져 올라옵니다. 이 현상을 보기 위해서는 흑점을 집중해주세요."),
    PlanetContentsList(planetName: "달"),
    PlanetContentsList(planetName: "수성"),
    PlanetContentsList(planetName: "금성",
                       planetInfoFirstTitle: "금성에 도착하다",
                       planetInfoFirstContents: "태양 다음으로 가장 밝게 빛나는 행성을 따라가니 금성에 도착했습니다. 밤하늘에서 금빛으로 반짝이는 금성은 태양계에서 가장 아름다운 행성으로 여러 신화를 통해 미의 여신으로 불리고는 했습니다. 미의 여신을 생각하면서 금성을 여행해봅시다.",
                       planetInfoSecondTitle: "금성의 두얼굴",
                       planetInfoSecondContents: "아름다운 금성을 여행할 여러분들은 이제부터 단단히 각오하셔야 합니다. 금빛 아름다움 속에 날카로운 가시를 품고있기 때문입니다. 금성은 두껍고 밀도 높은 대기 때문에 극심한 온실 효과가 발생합니다. 실제로 금성의 표면 온도는 465℃까지 올라갑니다. 더위를 피할 수 있는 곳을 찾아 어서 들어갑시다.",
                       planetInfoLastTitle: "금성에서 시작하는 하루",
                       planetInfoLastContents: "더위를 피할 수 있는 곳에서 잠을 자고 일어나니 저 멀리 해가 뜨고 있습니다. 금성에서는 아주 특이한 자연현상을 만날 수 있는데요. 바로 해가 서쪽에서 뜨는 것입니다.  금성은 지구와 달리 시계방향으로 자전을 하기 때문인데요. 서쪽에서 뜨는 해는 어떻게 다를지 한번 느껴봅시다. "),
    PlanetContentsList(planetName: "화성",
                       planetInfoFirstTitle: "화성에 도착하다",
                       planetInfoFirstContents: "지구에서 58,000km/h로 달리는 가장 빠른 우주선을 타고 이동하니 39일만에 저 멀리 화성이 보입니다. 화성의 표면은 주로 울퉁불퉁한 현무암으로 구성되어 있고 토양에 산화철이 널리 퍼져 있어 붉은색을 띄고 있네요.",
                       planetInfoSecondTitle: "화성을 관광하다",
                       planetInfoSecondContents: "드디어 화성에 내렸습니다. 이번 여행은 화성의 다이나믹한 지형을 즐기는 산악여행입니다. 저기 웅장한 마리너 계곡이 있습니다. 마리너 계곡은 길이 4,023km, 깊이 10km에 달하는 태양계에서 가장 큰 골짜기로 그 크기만으로도 압도적인 화성의 필수 산악 코스입니다. 이러한 지형은 과거 엄청난 양의 물이 흐르면서 형성된 것으로, 그 수량은 아마존강의 2백 배 이상으로 추정되고 있습니다.",
                       planetInfoLastTitle: "여행의 마무리",
                       planetInfoLastContents: "드디어 일몰의 시간입니다. 마리너 계곡의 풍경 좋은 곳에 자리를 잡고 앉아 일몰을 관찰합니다. 지평선 너머 푸른빛의 노을을 볼 수 잇습니다. 화성의 붉은 먼지들이 햇빛을 산란시켜 낮에는 붉고 해질녘에는 파랗게 보이는 것입니다. 멋진 일몰을 보며 화성에서의 하루가 마무리됩니다."),
    PlanetContentsList(planetName: "목성",
                       planetInfoFirstTitle: "목성에 도착하다",
                       planetInfoFirstContents: "태양계에서 가장 크기가 큰 행성을 찾아오니 목성에 도착했습니다. 목성은 태양계에 있는 다른 모든 행성을 합친 것보다 두 배 이상 무겁고 반지름은 지구의 11배입니다. 지구가 포도라면 목성은 농구공 정도의 크기를 가지고 있답니다. 목성의 크기가 느껴지시나요? 이렇게 커다란 목성을 다 둘러보려면 서둘러서 움직여야겠네요.",
                       planetInfoSecondTitle: "목성의 날씨",
                       planetInfoSecondContents: "즐거운 여행을 위해 꼭 필요한 것은 맑은 날씨입니다. 하지만 목성에서는 강한 뇌우와 거대한 폭풍을 조심해야 합니다. 목성의 폭풍 대적점은 붉은색을 띠는 타원형의 반점 모습을 하고 있습니다. 지구의 두배 넓이를 가지고 있는 이 거대하고 강력한 폭풍은 목성에서 150년 이상의 기간동안 소용돌이치고 있다하니 다들 조심하세요.",
                       planetInfoLastTitle: "위성으로 떠나는 여행",
                       planetInfoLastContents: "이번에는 목성 주변 위성인 얼음행성 유로파로 출발해봅시다. 얼음으로 덮여있는 유로파에서 스케이트를 타보세요. 이 얼음 지각 밑에는 생명체가 살 수 있는 광대한 바다가 있다는 증거가 있어 과학자들의 관심을 받고 있습니다. 이 밖에도 넘치는 매력을 가지는 목성은 주변을 끌어당기는 자기장으로 주변 위성만 80개 입니다. 다음은 어떤 위성으로 여행을 떠나볼까요?"),
    PlanetContentsList(planetName: "토성"),
    PlanetContentsList(planetName: "천왕성"),
    PlanetContentsList(planetName: "해왕성")
]
