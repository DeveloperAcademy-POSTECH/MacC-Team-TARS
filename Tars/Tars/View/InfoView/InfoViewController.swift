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
    
    private lazy var customPlanetInfoChapters: [CustomPlanetInfoView] = [CustomPlanetInfoView(), CustomPlanetInfoView(), CustomPlanetInfoView()]
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
