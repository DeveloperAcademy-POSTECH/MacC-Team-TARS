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
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(-360)), z: 0, duration: 30)
        let rotateForever = SCNAction.repeatForever(action)
        scene.rootNode.childNode(withName: "Cube_002", recursively: true)?.runAction(rotateForever)
        
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = UIColor.clear
        
        sceneView.cameraControlConfiguration.allowsTranslation = false
        sceneView.cameraControlConfiguration.autoSwitchToFreeCamera = true
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
                customPlanetInfoChapterOne.chapter.text = "Chapter 1"
                customPlanetInfoChapterOne.planetInfoTitle.text = $0.planetTitle1
                customPlanetInfoChapterOne.planetInfoContents.text = $0.planetContents1
                
                customPlanetInfoChapterTwo.chapter.text = "Chapter 2"
                customPlanetInfoChapterTwo.planetInfoTitle.text = $0.planetTitle2
                customPlanetInfoChapterTwo.planetInfoContents.text = $0.planetContents2
                
                customPlanetInfoChapterThree.chapter.text = "Chapter 3"
                customPlanetInfoChapterThree.planetInfoTitle.text = $0.planetTitle3
                customPlanetInfoChapterThree.planetInfoContents.text = $0.planetContents3
            }
        }

        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        [sceneView, customInfoScrollView].forEach { view.addSubview($0) }
        customInfoScrollView.addSubview(customInfoStackView)
        configureConstraints()
    }

    private func configureConstraints() {
        sceneView.centerX(inView: view)
        sceneView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: screenHeight / 21.6, width: screenWidth, height: screenWidth / 1.56)
        
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
