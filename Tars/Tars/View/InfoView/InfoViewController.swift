//
//  InfoViewController.swift
//  Tars
//
//  Created by Ayden on 2022/10/24.
//

import UIKit
import Combine
import SceneKit.ModelIO

import SnapKit
import Then

class InfoViewController: UIViewController {
    
    var cancellables = Set<AnyCancellable>()
    var currentPlanet: Planet? {
        didSet {
            if let planet = currentPlanet {
                let planetString = planet.rawValue
            }
        }
    }
    /*
     private var customPlanetInfoChapterOne = CustomPlanetInfoView()
     private var customPlanetInfoChapterTwo = CustomPlanetInfoView()
     private var customPlanetInfoChapterThree = CustomPlanetInfoView()
     
     private var audioManager = AudioManager()
     
     lazy var sceneView: SCNView = {
     let sceneView = SCNView()
     
     // usdz 파일 사용하기 위해 url 받아온 뒤 scene을 생성합니다.
     let path = Bundle.main.path(forResource: currentPlanet?.nameEnglish, ofType: ResourceConstants.usdz.name, inDirectory: "3dPlanets") ?? ""
     guard let url = URL(string: path) else { return sceneView }
     let mdlAsset = MDLAsset(url: url)
     mdlAsset.loadTextures()
     let scene = SCNScene(mdlAsset: mdlAsset)
     
     scene.rootNode.childNode(withName: ResourceConstants.Cube_002.name, recursively: true)
     scene.rootNode.scale = SCNVector3(1.13, 1.13, 1.13)
     
     // 오브젝트가 회전하는 애니메이션(액션)을 추가합니다.
     let action = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(-360)), z: 0, duration: 30)
     let rotateForever = SCNAction.repeatForever(action)
     scene.rootNode.childNode(withName: ResourceConstants.Cube_002.name, recursively: true)?.runAction(rotateForever)
     
     // 토성인 경우, 고리가 보이게 pitch 각도를 조정합니다.
     if currentPlanet == .saturn {
     scene.rootNode.eulerAngles = SCNVector3(0.1, 0, 0)
     }
     sceneView.allowsCameraControl = true
     sceneView.backgroundColor = UIColor.clear
     
     sceneView.cameraControlConfiguration.allowsTranslation = false
     sceneView.cameraControlConfiguration.autoSwitchToFreeCamera = true
     
     // 한 손가락을 제외한 손가락 제스처를 막습니다.
     for reco in sceneView.gestureRecognizers! {
     if let panReco = reco as? UIPanGestureRecognizer {
     panReco.maximumNumberOfTouches = 0
     }
     if let panReco = reco as? UIPinchGestureRecognizer {
     panReco.isEnabled = false
     }
     }
     
     // 조명 추가
     sceneView.autoenablesDefaultLighting = true
     sceneView.scene = scene
     
     sceneView.isAccessibilityElement = true
     sceneView.accessibilityLabel = "\(String(describing: currentPlanet?.planetName)) \(LocalizableKeys.image)"
     
     return sceneView
     }()
     
     lazy var customInfoScrollView: UIScrollView = {
     let scrollView = UIScrollView()
     scrollView.backgroundColor = .clear
     scrollView.accessibilityScroll(.down)
     return scrollView
     }()
     
     lazy var customInfoStackView: UIStackView = {
     let stackView = UIStackView(arrangedSubviews: [self.customPlanetInfoChapterOne, self.customPlanetInfoChapterTwo, self.customPlanetInfoChapterThree])
     customPlanetInfoChapterOne.setContentsIndex(planet: currentPlanet ?? .mars, chapterIndex: 1)
     customPlanetInfoChapterTwo.setContentsIndex(planet: currentPlanet ?? .mars, chapterIndex: 2)
     customPlanetInfoChapterThree.setContentsIndex(planet: currentPlanet ?? .mars, chapterIndex: 3)
     
     stackView.distribution = .fillProportionally
     stackView.axis = .vertical
     stackView.alignment = .leading
     return stackView
     }()
     
     // MARK: - Lifecycle
     
     override func viewDidLoad() {
     super.viewDidLoad()
     view.backgroundColor = .black
     
     PlanetManager.shared.$currentPlanet
     .assign(to: \.currentPlanet, on: self)
     .store(in: &cancellables)
     
     [sceneView, customInfoScrollView].forEach { view.addSubview($0) }
     customInfoScrollView.addSubview(customInfoStackView)
     
     let chapters = [customPlanetInfoChapterOne, customPlanetInfoChapterTwo, customPlanetInfoChapterThree]
     let hints = [LocalizableKeys.chapterOneHint, LocalizableKeys.chapterTwoHint, LocalizableKeys.chapterThreeHint]
     
     chapters.enumerated().forEach { index, chapterInfo in
     chapterInfo.chapter.accessibilityHint = hints[index].localized
     }
     
     configureConstraints()
     navigationItem.title = currentPlanet?.planetName
     
     // 해당 천체의 사운드 재생
     audioManager.playAudio(pre: AudioMode.detail.prefix,
     fileName: currentPlanet?.nameEnglish ?? String(),
     audioExtension: ResourceConstants.mp3.name,
     audioVolume: AudioVolume.half.volume,
     isLoop: true)
     }
     
     /// 화면이 사라질 경우 사운드 재생 중지
     override func viewDidDisappear(_ animated: Bool) {
     super.viewDidDisappear(true)
     audioManager.pauseAudio()
     audioManager.audioPlayer?.prepareToPlay()
     }
     
    private func configureConstraints() {
        sceneView.centerX(inView: view)
        
        if currentPlanet == .saturn {
            sceneView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: screenHeight / 21.6, width: screenWidth, height: screenWidth / 1.56)
            customInfoScrollView.anchor(top: sceneView.bottomAnchor,
                                        leading: view.leadingAnchor,
                                        bottom: view.bottomAnchor,
                                        trailing: view.trailingAnchor,
                                        paddingTop: screenHeight / 21.1)
        } else {
            // 토성의 고리가 보이게 height를 늘리고, 컨텐츠와의 padding 간격을 늘립니다.
            sceneView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: screenHeight / 52.75, width: screenWidth, height: screenWidth / 1.2)
            customInfoScrollView.anchor(top: sceneView.bottomAnchor,
                                        leading: view.leadingAnchor,
                                        bottom: view.bottomAnchor,
                                        trailing: view.trailingAnchor,
                                        paddingTop: screenHeight / 52.75)
        }
        
        customInfoStackView.anchor(top: customInfoScrollView.topAnchor,
                                   leading: customInfoScrollView.leadingAnchor,
                                   bottom: customInfoScrollView.bottomAnchor,
                                   trailing: customInfoScrollView.trailingAnchor)
        customInfoStackView.setWidth(width: customInfoScrollView.frame.width)
    }
     
     deinit { }
     */
    
    private var customPlanetInfoChapters: [CustomPlanetInfoView] = [CustomPlanetInfoView(), CustomPlanetInfoView(), CustomPlanetInfoView()]
    private var audioManager = AudioManager()
    
    private lazy var sceneView = SCNView().then {
        configureSceneView($0)
    }
    
    private lazy var customInfoScrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.accessibilityScroll(.down)
    }
    
    private lazy var customInfoStackView = UIStackView(arrangedSubviews: customPlanetInfoChapters).then {
        $0.distribution = .fillProportionally
        $0.axis = .vertical
        $0.alignment = .leading
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        bindCurrentPlanet()
        
        [sceneView, customInfoScrollView].forEach { view.addSubview($0) }
        customInfoScrollView.addSubview(customInfoStackView)
        
        configureChapterAccessibilityHints()
        configureConstraints()
        
        navigationItem.title = currentPlanet?.planetName
        
        playPlanetAudio()
    }
    
//    deinit { }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        audioManager.pauseAudio()
        audioManager.audioPlayer?.prepareToPlay()
    }
}

private extension InfoViewController {
    
    func bindCurrentPlanet() {
        PlanetManager.shared.$currentPlanet
            .assign(to: \.currentPlanet, on: self)
            .store(in: &cancellables)
    }
    
    func configureSceneView(_ sceneView: SCNView) {
        let path = Bundle.main.path(forResource: currentPlanet?.nameEnglish, ofType: ResourceConstants.usdz.name, inDirectory: "3dPlanets") ?? ""
        guard let url = URL(string: path) else { return }
        
        let mdlAsset = MDLAsset(url: url)
        mdlAsset.loadTextures()
        let scene = SCNScene(mdlAsset: mdlAsset)
        
        let planetNode = scene.rootNode.childNode(withName: ResourceConstants.Cube_002.name, recursively: true)
        planetNode?.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(-360)), z: 0, duration: 30)))
        
        if currentPlanet == .saturn {
            scene.rootNode.eulerAngles = SCNVector3(0.1, 0, 0)
        }
        
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = .clear
        sceneView.cameraControlConfiguration.allowsTranslation = false
        sceneView.cameraControlConfiguration.autoSwitchToFreeCamera = true
        disableUnwantedGestures(in: sceneView)
        
        sceneView.autoenablesDefaultLighting = true
        sceneView.scene = scene
        
        sceneView.isAccessibilityElement = true
        sceneView.accessibilityLabel = "\(String(describing: currentPlanet?.planetName)) \(LocalizableKeys.image)"
    }
    
    func disableUnwantedGestures(in sceneView: SCNView) {
        sceneView.gestureRecognizers?.forEach { reco in
            if let panReco = reco as? UIPanGestureRecognizer {
                panReco.maximumNumberOfTouches = 0
            }
            
            if let pinchReco = reco as? UIPinchGestureRecognizer {
                pinchReco.isEnabled = false
            }
        }
    }
    
    func configureChapterAccessibilityHints() {
        let hints = [LocalizableKeys.chapterOneHint, LocalizableKeys.chapterTwoHint, LocalizableKeys.chapterThreeHint]
        for (index, chapter) in customPlanetInfoChapters.enumerated() {
            chapter.setContentsIndex(planet: currentPlanet ?? .mars, chapterIndex: index + 1)
            chapter.chapter.accessibilityHint = hints[index].localized
        }
    }
    
    func playPlanetAudio() {
        audioManager.playAudio(fileName: AudioMode.detail.prefix,
                               audioExtension: currentPlanet?.nameEnglish ?? "",
                               audioVolume: AudioVolume.half.volume,
                               isLoop: true)
    }
    
    func configureConstraints() {
        
        let topPadding: CGFloat = currentPlanet == .saturn ? screenHeight / 21.6 : screenHeight / 52.75
        let heightMultiplier: CGFloat = currentPlanet == .saturn ? 1.56 : 1.2
        
        sceneView.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(topPadding)
            $0.width.equalToSuperview()
            $0.height.equalTo(sceneView.snp.width).dividedBy(heightMultiplier)
        }
        
        customInfoScrollView.snp.makeConstraints {
            $0.top.equalTo(sceneView.snp.bottom).offset(screenHeight / 21.1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        customInfoStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
}
