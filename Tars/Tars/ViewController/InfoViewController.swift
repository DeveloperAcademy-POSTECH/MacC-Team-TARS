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
    
    lazy var planetName: UILabel = {
        let planetName = UILabel()
        planetName.text = planet.planetKoreanName
        planetName.font = .preferredFont(forTextStyle: .largeTitle)
        if let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title1).withSymbolicTraits(.traitBold) {
            planetName.font = .init(descriptor: descriptor, size: 0)
        }
        planetName.textColor = .white
        planetName.adjustsFontForContentSizeCategory = true
        return planetName
    }()
    
    lazy var planetInfo: UILabel = {
        let planetInfo = UILabel()
        // TODO: content text 수정
        planetInfo.text = PlanetStrings.jupiterContent.localizedKey
        planetInfo.font = .preferredFont(forTextStyle: .title3)
        planetInfo.setLineSpacing(spacing: 6)
        planetInfo.textColor = .white
        planetInfo.adjustsFontForContentSizeCategory = true
        planetInfo.numberOfLines = 0
        return planetInfo
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        [sceneView, planetName, planetInfo].forEach { view.addSubview($0) }
        configureConstraints()
    }

    private func configureConstraints() {
        sceneView.centerX(inView: view)
        sceneView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: screenHeight / 21.6, width: screenWidth, height: screenWidth / 1.56)
        
        planetName.centerX(inView: view)
        planetName.anchor(top: sceneView.bottomAnchor, paddingTop: screenHeight / 21.6)
        
        planetInfo.centerX(inView: view)
        planetInfo.anchor(top: planetName.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: screenWidth / 26.3, paddingLeading: screenWidth / 9.75, paddingTrailing: screenWidth / 9.75)
    }
}
