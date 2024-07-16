//
//  UniverseMainViewController.swift
//  Tars
//
//  Created by ParkJunHyuk on 7/16/24.
//

import Foundation
import UIKit
import SceneKit
import ARKit

import SnapKit
import Then

final class UniverseMainViewController: UIViewController {
    
    // MARK: - Properties
    
    // TODO: - 해당 프로퍼티는 VM 로 위치 변경 필요
    private var planetObjectList: [String: SCNNode] = [:]
    private var planetObjectSound: [String: SCNAudioPlayer] = [:]
    private var circleCenter: CGPoint = .zero
    
    // MARK: - UI Properties
    
    private lazy var arSceneView: ARSCNView = ARSCNView()
    private let searchGuideLabel: UILabel = UILabel()
    private let selectPlanetCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Custom UI Properties
    
    private var guideCircleView = CustomCircleView()
    private var selectedSquareView = CustomSquareView()
    private var guideArrowView = CustomArrowView()
    private var coachingOverlayView = CustomOnboardingOverlayView()
    private var coachingBackgroundOverlayView = CustomBackgroundOverlayView()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureDelegate()
        configureStyle()
        configureHierarchy()
        configureLayout()
        configureTapGesture()
        configureVoiceOver()
        configureNavigationTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravityAndHeading
        arSceneView.session.run(configuration)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        circleCenter = guideCircleView.center
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        arSceneView.session.pause()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
//        muteExploreSearchModeSound(soundPlayer: planetObjectSound)
    }
}
 
// MARK: - objc Extension

private extension UniverseMainViewController {
    /// square 를 눌렀을 때 화면 전환을 하는  메서드
    @objc func squareViewTapped() {
        let infoViewController = InfoViewController()
        self.navigationController?.pushViewController(infoViewController, animated: true)
    }
}

// MARK: - Configure View Layout

private extension UniverseMainViewController {
    
    /// Delegate 를 할당하는 메서드
    func configureDelegate() {
        arSceneView.delegate = self
        selectPlanetCollectionView.delegate = self
        selectPlanetCollectionView.dataSource = self
    }
    
    /// UIView 의 Layout 을 할당하는 메서드
    func configureStyle() {
        coachingOverlayView.do {
            $0.layer.zPosition = 1
        }
        
        searchGuideLabel.do {
            $0.text = LocalizableKeys.collectionViewTitle.localized
            $0.accessibilityHint = LocalizableKeys.collectionViewContent.localized
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 20, weight: .semibold)
        }
        
        selectPlanetCollectionView.do {
            $0.register(SelectPlanetCollectionViewCell.self, forCellWithReuseIdentifier: SelectPlanetCollectionViewCell.identifier)
            $0.backgroundColor = .black
            $0.showsHorizontalScrollIndicator = true
            $0.contentInset = UIEdgeInsets(top: 0, left: screenWidth * 0.09, bottom: 0, right: screenWidth * 0.09)
        }
    }
    
    /// VC 에 출력할 요소를 할당하는 메서드
    func configureHierarchy() {
        view.addSubviews(coachingBackgroundOverlayView, coachingOverlayView, arSceneView, selectPlanetCollectionView, searchGuideLabel)
        
        arSceneView.addSubviews(guideCircleView, guideArrowView, selectedSquareView)
    }
    
    /// Snapkit 을 이용해  AutoLayout 을 설계하는 메서드
    func configureLayout() {
        coachingOverlayView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(screenHeight * 0.23)
            $0.centerX.equalToSuperview()
        }
         
        searchGuideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(screenHeight * 0.7)
        }
        
        selectPlanetCollectionView.snp.makeConstraints {
            $0.height.equalTo(screenHeight * 0.35)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        arSceneView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(screenHeight * 0.1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        guideCircleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(screenHeight * 0.7)
            $0.centerX.equalToSuperview()
        }
        
        selectedSquareView.frame = CGRect(x: 0, y: 0, width: screenWidth / 5.65, height: (screenWidth / 5.65) + (screenHeight / 26.375))
        
        guideArrowView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    }
    
    /// 제스처를 할당하기 위한 메서드
    func configureTapGesture() {
        let selectedSquareViewTap = UITapGestureRecognizer(target: self, action: #selector(squareViewTapped))
        selectedSquareView.addGestureRecognizer(selectedSquareViewTap)
    }
    
    /// VoiceOver 를 구성하기 위한 메서드
    func configureVoiceOver() {
        coachingOverlayView.isAccessibilityElement = true
        coachingOverlayView.accessibilityLabel = LocalizableKeys.onboardingInstructionstring.localized
        UIAccessibility.post(notification: .layoutChanged, argument: coachingOverlayView)
        
        self.accessibilityElements = [selectPlanetCollectionView]
    }
    
    /// VC 의 NavigationTitle 을 설정하는 메서드
    func configureNavigationTitle() {
        self.navigationController?.navigationBar.layer.zPosition = 0
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.topViewController?.title = LocalizableKeys.exploreUniverseNavigationTitle.localized
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.layer.zPosition = -1
    }
}

// MARK: - ARSCNViewDelegate

extension UniverseMainViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
//        switch mode {
//        case .explore:
//            explore()
//        case .search(planet: let name):
//            search(for: name)
//        }
    }
}

// MARK: - LocationManagerDelegate

private extension UniverseMainViewController {
    func updateUserLocation() {
        Task {
            let bodies = try await HorizonsAPIManager().requestBodies()
//            setPlanetPosition(to: arSceneView.scene, planets: bodies)
        }
    }
}

// MARK: - ARKit 관련 Planet Sphere, Node 메서드

private extension UniverseMainViewController {
    /// 행성의 데이터를 통해 구를 만드는 메서드
    /// - Parameters:
    ///     - plaaents : API 를 통해 받은 Planet 데이터를 갖고 있는 배열
    /// - Returns: SCNSphere 으로  만들어진 Planet 구체의 데이터를 담고 있는 배열
    func makePlanetSphere(planets: [Body]) -> [SCNSphere]  {
        return planets.map {
            let sphere = SCNSphere(radius: 0.2)
            sphere.firstMaterial?.diffuse.contents = UIImage(named: $0.name + "_Map")
            
            return sphere
        }
    }
    
    /// Planet Sphere 를 통해 Node ( 위치 정보를 담고 있는 ) 를 만드는 메서드
    /// - Parameters:
    ///     - plaaents : API 를 통해 받은 Planet 데이터를 갖고 있는 배열
    ///     - planetSpheres : makePlanetSphere 메서드 에서 만든 각 행성에 대한 SCNSphere
    /// - Returns: planetSpheres 의 데이터를 통해 만든 SCNNode 배열
    func makePlanetNode(planets: [Body], planetSpheres: [SCNSphere]) -> [SCNNode] {
        return planets.enumerated().map { index, planet in
            let sphereNode = SCNNode(geometry: planetSpheres[index])
            sphereNode.position = SCNVector3(planet.coordinate.x, planet.coordinate.y, planet.coordinate.z)
            sphereNode.name = planet.name

            planetObjectList[planet.name] = sphereNode
            
            return sphereNode
        }
    }
    
    /// SNCScene 에 PlanetNode 를 배치하는 메서드
    /// - Parameters:
    ///     - scene : SceneKit 으로 만든 객체를 해당 scene 에 렌더링하기 위한 View
    ///     - planetNodes : Planet 데이터를 통해 만든 SCNNode
    func setupPlanetPosition(to scene: SCNScene?, planetNodes: [SCNNode]) {
        planetNodes.forEach {
            scene?.rootNode.addChildNode($0)
        }
    }
    
    /// PlanetNode 에 Audio 소스를 추가하기 위한 메서드
    /// - Parameters:
    ///     - plaaents : API 를 통해 받은 Planet 데이터를 갖고 있는 배열
    ///     - planetNodes : makePlanetNode 메서드 에서 만든 각 행성에 대한 SCNNode
    /// - Returns: audioSource 의 정보를 담고 있는 SCNNode 배열
    func addAudioToPlanetNode(planets: [Body], planetNodes: [SCNNode]) -> [SCNNode] {
        return planets.enumerated().map { index, planet in
            let audioSource = SCNAudioSource(fileNamed: "\(AudioMode.search.prefix)\(planet.name).\(ResourceConstants.mp3.name)")!
            
            // 노드와 해당 위치에와 소스의 볼륨, 반향 및 거리에 따라 자동으로 변경
            audioSource.isPositional = true
            audioSource.volume = 0.5
            audioSource.loops = true
            audioSource.load()
            
            let scnPlayer = SCNAudioPlayer(source: audioSource)
            
            planetNodes[index].removeAllAudioPlayers()
            planetNodes[index].addAudioPlayer(scnPlayer)
            
            planetObjectSound[planet.name] = scnPlayer
            
            return planetNodes[index]
        }
    }
}
