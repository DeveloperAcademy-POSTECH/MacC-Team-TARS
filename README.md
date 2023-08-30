<div align="center" >
  
<img width="150" src="https://user-images.githubusercontent.com/50728605/206730790-000448a9-d169-4025-bde9-c334b45c2415.jpg">

# SpaceOver
Apple Developer Academy @ POSTECH 1기 Spotlight 프로젝트
> **“Hear the Universe”** <br/><br/>
> 시각작애인 유저들이 스스로 우주를 탐색하고 태양계의 천체들을 찾을 수 있는 천문학적 경험을 제공합니다. <br/>
> SpaceOver provides an astronomical experience for BVI(blind and visually impaired) users <br/>to independently navigate through space and locate the planets of the solar system.
  
</div>
<div style="display: flex; flex-direction: column;" align="center" >
  <a href="https://apps.apple.com/kr/app/spaceover/id6444027977">
    <img src="https://user-images.githubusercontent.com/81340603/204947353-18c33fe9-c49b-443a-b1e2-7cf9a85bb91b.png" width=180px />
  </a>
  <p3>&nbsp;&nbsp;&nbsp;</p3>
</div>
<br/>


### 💡Features 
- **천체의 실시간 위치** : 사용자의 위치를 기준으로 천체의 실시간 위치 제공
- **천체 검색** : 찾고싶은 천체를 선택해 음악 및 화살표를 따라 천체 검색 가능
- **천체 여행** : 찾은 천체를 선택하여 천체 여행. 아름다운 3D 천체 애니메이션 및 천체 고유의 음악과 함께 천체 여행 가이드 제공
- **공간음향** : 음악이 들리는 방향으로 천체의 위치를 찾을 수 있도록 안내. 에어팟 등 공간음향을 지원하는 이어폰이라면 사용 가능
- **보이스오버** : 아이폰 설정 > 손쉬운 사용 > VoiceOver 를 활성화하여, 앱 내의 컨텐츠를 음성으로 안내 
- **Localization** : 영어 & 한국어 지원 
<br><br>

### 📱 Screenshots
| Name | Screenshot | Detail |
|:---:|:---:|---|
|**Launchscreen**|<img width="200" src="https://user-images.githubusercontent.com/50728605/206733045-e25ec0ac-b76e-4765-8781-e68df3de3e79.png">|- 앱 실행 시 에어팟 착용을 권장 <br> - 가독성을 위해 bold text 사용 <br> - 보이스오버 : 앱이름과 텍스트 읽음 |
|**Explore**|<img width="200" src="https://user-images.githubusercontent.com/50728605/206731765-d0f27273-7ad7-4670-90c4-f4c02ee118a8.png">|- AR 권한을 허용하면 주변을 둘러보도록 안내 <br> - 사용자의 위치를 기반하여 실시간 천체의 위치를 API를 통해 받아옴 <br> - 천체가 감지되는 경우 알림음 및 진동으로 알려줌 <br> - 공간음향: 모든 천체의 음악이 하나의 음악을 이뤄 배경음악으로 들림 |
|**Search**|<img width="200" src="https://user-images.githubusercontent.com/50728605/206731938-11860f67-8759-4cb0-b641-91d875ce3d37.png">|- 찾고싶은 천체를 아래 표에서 선택 <br> - 선택한 천체의 음악이 단독으로 들림 <br> - 천체의 방향에 따라 음악이 들리는 방향이 달라짐 <br> - 해당 천체가 있는 방향을 화살표로 알려줌 <br> - 보이스오버: 이동해야 하는 방향 및 찾게된 경우 이를 알려줌<br> - 찾은 천체를 탭하면 해당 천체로 여행을 떠남|
|**Travel**|<img width="200" src="https://user-images.githubusercontent.com/50728605/206731817-7ebcf70d-7c63-4f1d-b29c-ad1e47a7ea6e.png">|- 상호작용 가능한 3D 이미지 제공 및 천체의 특성을 고려한 천체 여행 가이드 제공 <br> - 해당 천체 음악 감상 가능 <br> - 시각적 요소 없이 천체를 묘사하도록 컨텐츠 제작|

<br><br>

### :sparkles: Skills & Tech Stack
|구분|항목|
|:---:|---|
|**Environment**|iOS 15.0+, Xcode 14.0|
|**Framework**|UIKit, Codebase, ARKit, SceneKit, CoreLocation, Haptics|
|**Version Control**|Git, GitHub|
|**Design**|Figma, Illustration|
|**Communication**|Notion, Slack, Gather, Miro|

<br><br>

### 🫂 Developers

|박준혁|석혜민|오세익|조은우|손희지|김소현|이윤영|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|<img src="https://github.com/Genesis2010.png" width="190">|<img src="https://github.com/lenamin.png" width="190">|<img src="https://github.com/glitterer.png" width="190">|<img src = "https://github.com/DoAY9.png" width="190">|<img src="https://github.com/HeejiSohn.png" width="190">|<img src="https://github.com/SohyeonKim-dev.png" width="190">|<img src="https://github.com/YoonyoungL.png" width="190">|
|[Niro](https://github.com/Genesis2010)|[Lena](https://github.com/lenamin)|[Oz](https://github.com/glitterer)|[Ayden](https://github.com/DoAY9)|[Sohni](https://github.com/HeejiSohn)|[Colli](https://github.com/SohyeonKim-dev)|[Jerry](https://github.com/YoonyoungL)|
|<p align="left">- ARKit 관련 기능<br>- 행성 배치 구현<br>- 오디오 재생 기능 구현|<p align="left">- 오디오 기능 및 음원 제작<br>- InfoView 구현<br>- VoiceOver 기능<br>- 배포 및 유지보수|<p align="left">- Localization<br>- VoiceOver 기능<br>- LaunchScreen 구현|<p align="left">- UI/UX 디자인 총괄<br>- 앱 로고 및 스크린샷 제작<br>- InfoView 구현<br>- 3D animation 구현|<p align="left">- 햅틱 기능 구현<br>- VoiceOver 기능<br>- 천체 컨텐츠 제작|<p align="left">- SearchView 구현<br>- MainView 구현<br>- tap gesture 기능<br>- 데이터 관련 구현|<p align="left">- 실시간 천체 위치 API 구현<br>- 네트워크 모델링<br>- 사용자 위치 모델<br>- 행성 탐색 로직|
