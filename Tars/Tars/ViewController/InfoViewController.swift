//
//  InfoViewController.swift
//  Tars
//
//  Created by Ayden on 2022/10/24.
//

import UIKit
import SceneKit.ModelIO

class InfoViewController: UIViewController {
    
    public var planet: Planet = Planet(planetKoreanName: "", planetEnglishName: "", planetImage: UIImage(named: ""))
    private var customPlanetInfoChapterOne = CustomPlanetInfoView()
    private var customPlanetInfoChapterTwo = CustomPlanetInfoView()
    private var customPlanetInfoChapterThree = CustomPlanetInfoView()
    private var planetContentsList: [PlanetContent] = PlanetContent.planetContentsList
    
    private var audioManager = AudioManager()
    
    lazy var sceneView: SCNView = {
        let sceneView = SCNView()
        
        // usdz 파일 사용하기 위해 url 받아온 뒤 scene을 생성합니다.
        let path = Bundle.main.path(forResource: planet.planetEnglishName, ofType: "usdz", inDirectory: "3dPlanets") ?? ""
        let url = URL(string: path)

        let mdlAsset = MDLAsset(url: url!)
        mdlAsset.loadTextures()
        let scene = SCNScene(mdlAsset: mdlAsset)

        scene.rootNode.childNode(withName: "Cube_002", recursively: true)
        scene.rootNode.scale = SCNVector3(1.13, 1.13, 1.13)
        
        // 오브젝트가 회전하는 애니메이션(액션)을 추가합니다.
        var action = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(-360)), z: 0, duration: 30)
        let rotateForever = SCNAction.repeatForever(action)
        
        // 토성인 경우 pitch 각도를 조정합니다.
        if planet.planetEnglishName == "Saturn" {
            scene.rootNode.scale = SCNVector3(1.25, 1.25, 1.25)
            scene.rootNode.eulerAngles = SCNVector3(0.08, 0, 0)
        }
        scene.rootNode.childNode(withName: "Cube_002", recursively: true)?.runAction(rotateForever)
        
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = UIColor.clear
        
        sceneView.cameraControlConfiguration.allowsTranslation = false
        sceneView.cameraControlConfiguration.autoSwitchToFreeCamera = true
        
        // 한 손가락을 제외한 손가락 제스처를 막습니다.
        for reco in sceneView.gestureRecognizers! {
            if let panReco = reco as? UIPanGestureRecognizer {
                panReco.maximumNumberOfTouches = 1
            }
            if let panReco = reco as? UIPinchGestureRecognizer {
                panReco.isEnabled = false
            }
        }
        
        // 조명 추가
        sceneView.autoenablesDefaultLighting = true
        sceneView.scene = scene
        
        sceneView.isAccessibilityElement = true
        sceneView.accessibilityLabel = "\(planet.planetKoreanName) 이미지"
        
        return sceneView
    }()
    
    lazy var customInfoScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var customInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [customPlanetInfoChapterOne, customPlanetInfoChapterTwo, customPlanetInfoChapterThree])
        
        planetContentsList.forEach {
            if planet.planetKoreanName == $0.planetName {
                customPlanetInfoChapterOne.setInfoContents(chapter: "Chapter 1", title: $0.planetTitle1, contents: $0.planetContents1)
                customPlanetInfoChapterTwo.setInfoContents(chapter: "Chapter 2", title: $0.planetTitle2, contents: $0.planetContents2)
                customPlanetInfoChapterThree.setInfoContents(chapter: "Chapter 3", title: $0.planetTitle3, contents: $0.planetContents3)
            }
        }

        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        [sceneView, customInfoScrollView].forEach { view.addSubview($0) }
        customInfoScrollView.addSubview(customInfoStackView)
        configureConstraints()
        navigationItem.title = planet.planetKoreanName
        
        // 해당 천체의 사운드 재생
        audioManager.playAudio(fileName: planet.planetEnglishName)
    }
    
    /// 화면이 사라질 경우 사운드 재생 중지
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        audioManager.pauseAudio()
    }

    private func configureConstraints() {
        sceneView.centerX(inView: view)
        if planet.planetEnglishName == "Saturn" {
            sceneView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             paddingTop: screenHeight / 35.16,
                             width: screenWidth,
                             height: screenHeight)
            customInfoStackView.anchor(top: sceneView.bottomAnchor,
                                       leading: view.leadingAnchor,
                                       bottom: view.bottomAnchor,
                                       trailing: view.trailingAnchor,
                                       paddingTop: screenHeight / 26.37,
                                       paddingLeading: screenWidth / 12.18)
        }
        sceneView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         paddingTop: screenHeight / 21.6,
                         width: screenWidth,
                         height: screenWidth / 1.56)
        
        customInfoStackView.anchor(top: customInfoScrollView.topAnchor,
                                   leading: customInfoScrollView.leadingAnchor,
                                   bottom: customInfoScrollView.bottomAnchor,
                                   trailing: customInfoScrollView.trailingAnchor)
        customInfoStackView.setWidth(width: customInfoScrollView.frame.width)
        
        customInfoScrollView.anchor(top: sceneView.bottomAnchor,
                                   leading: view.leadingAnchor,
                                   bottom: view.bottomAnchor,
                                   trailing: view.trailingAnchor,
                                   paddingTop: screenHeight / 21.1)
        
    }
}
