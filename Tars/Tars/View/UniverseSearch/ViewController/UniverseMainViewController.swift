//
//  UniverseMainViewController.swift
//  Tars
//
//  Created by ParkJunHyuk on 7/16/24.
//

import UIKit
import Combine
import SceneKit
import ARKit

import SnapKit
import Then

final class UniverseMainViewController: UIViewController {
    
    // MARK: - Properties
    
    private var planetObjectList: [String: SCNNode] = [:]
    private var circleCenter: CGPoint = .zero
    
    private var universeLocationViewModel = UniverseLocationViewModel()
    var universeModeViewModel = UniverseModeViewModel(sceneKitAudioVolumeManager: SceneKitAudioVolumeManager())
    
    private var cancellables = Set<AnyCancellable>()
    
    private let planetCollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var planetListData = [PlanetInfo]()
    var selectedIndexPath: IndexPath?
    
    private var audioManager = AudioManager.shared
    
    // MARK: - UI Properties
    
    private lazy var arSceneView: ARSCNView = ARSCNView()
    private let searchGuideLabel: UILabel = UILabel()
    private let selectPlanetCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Custom UI Properties
    
    private var guideCircleView = CustomCircleView()
    private var selectedSquareView = CustomSquareView()
    private var guideArrowView = CustomArrowView()
    private var onboardingView = OnboardingView()

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
        
        Planet.allCases.forEach {
            planetListData.append(
                PlanetInfo(
                    planetIdName: $0.nameEnglish,
                    planetName: $0.planetName,
                    planetImage: $0.nameEnglish,
                    isSelected: .notSelect
                )
            )
        }
        
        setUpAuthorizationBinding()
        setUpShowSettingBindidng()
        setUpNetworkState()
        setUpBodiesBinding()
        configureModeBinding()
        
        selectedSquareView.isHidden = true
        guideArrowView.isHidden = true
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
        
        universeModeViewModel.muteAllNode()
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
        onboardingView.do {
            $0.layer.zPosition = 1
        }
        
        planetCollectionViewFlowLayout.do {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = screenWidth * 0.05
            $0.minimumInteritemSpacing = CGFloat(UInt16.max)
        }
        
        searchGuideLabel.do {
            $0.text = LocalizableKeys.collectionViewTitle.localized
            $0.accessibilityHint = LocalizableKeys.collectionViewContent.localized
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 20, weight: .semibold)
        }
        
        selectPlanetCollectionView.do {
            let layout = UICollectionViewFlowLayout().then {
                $0.scrollDirection = .horizontal
                $0.minimumLineSpacing = screenWidth * 0.05
                $0.minimumInteritemSpacing = CGFloat(UInt16.max)
            }
            
            $0.register(SelectPlanetMainCollectionViewCell.self, forCellWithReuseIdentifier: SelectPlanetMainCollectionViewCell.identifier)
            $0.backgroundColor = .black
            $0.showsHorizontalScrollIndicator = true
            $0.contentInset = UIEdgeInsets(top: 0, left: screenWidth * 0.09, bottom: 0, right: screenWidth * 0.09)
            $0.allowsMultipleSelection = false
            $0.collectionViewLayout = layout
        }
    }
    
    /// VC 에 출력할 요소를 할당하는 메서드
    func configureHierarchy() {
        view.addSubviews(onboardingView, arSceneView, selectPlanetCollectionView, searchGuideLabel)
        
        arSceneView.addSubviews(guideCircleView, guideArrowView, selectedSquareView)
    }
    
    /// Snapkit 을 이용해  AutoLayout 을 설계하는 메서드
    func configureLayout() {
        onboardingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
         
        searchGuideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(screenHeight * 0.7)
            $0.centerX.equalToSuperview()
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
            $0.top.equalToSuperview().offset(screenHeight * 0.24 / 2)
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
        onboardingView.isAccessibilityElement = true
        onboardingView.accessibilityLabel = LocalizableKeys.onboardingInstructionstring.localized
        UIAccessibility.post(notification: .layoutChanged, argument: onboardingView)
        
        self.accessibilityElements = [selectPlanetCollectionView]
    }
    
    /// VC 의 NavigationTitle 을 설정하는 메서드
    func configureNavigationTitle() {
//        self.navigationController?.navigationBar.layer.zPosition = 0
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.topViewController?.title = LocalizableKeys.exploreUniverseNavigationTitle.localized
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        self.navigationItem.hidesBackButton = true
//        self.navigationController?.navigationBar.layer.zPosition = -1
    }
}

// MARK: - ARSCNViewDelegate

extension UniverseMainViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        switch universeModeViewModel.modeStateSubject.value {
        case .explore:
            explore()
        case .search(planet: let name):
            search(for: name)
        }
    }
}

// MARK: - LocationManagerDelegate
/*
private extension UniverseMainViewController {
    
    func updateUserLocation() {
        Task {
//            let bodies = try await HorizonsAPIManager().requestBodies()
            
        }
    }
}
*/

// MARK: - 탐색 / 검색 모드 기능

extension UniverseMainViewController {
    // MARK: - 탐색 모드 기능
    private func explore() {
        var detectNode: SCNNode?
        var nodeCenter: CGPoint = .zero
        var minDistance: CGFloat = screenHeight
        
        guard let pointOfView = arSceneView.pointOfView else { return }
        let detectNodes = arSceneView.nodesInsideFrustum(of: pointOfView) // 화면에 들어온 노드 리스트
        
        for node in detectNodes {
            let nodePosition = arSceneView.projectPoint(node.position)
            let nodeScreenPos = nodePosition.toCGPoint()
            let distance = circleCenter.distanceTo(nodeScreenPos)
            
            // 원 안에 들어온 가장 짧은 거리, 노드, 화면상의 위치 저장
            if distance < screenWidth / 3 && distance < minDistance {
                detectNode = node
                nodeCenter = nodeScreenPos
                minDistance = distance
            }
        }
        
        if let detectNode = detectNode {
            // 원 안에 들어온 노드 존재했을 때
            guard let detectedPlanet = detectNode.name else { return }
            
            let nodeOrigin = CGPoint(x: nodeCenter.x - screenWidth / 11.3, y: nodeCenter.y - screenWidth / 11.3)
            setDetectedLayout(name: detectedPlanet, point: nodeOrigin)
            
            universeModeViewModel.selectedNodeExploreMode(selectPlanetName: detectedPlanet)
            universeModeViewModel.updateDetectedNodeName(detectedPlanet)
        } else {
            // 탐지된 노드가 없을 때
            setNotDetectedLayout()
            universeModeViewModel.exploreMode()
        }
    }
    
    // MARK: - 검색 모드 기능
    private func search(for name: String) {
        guard let node = planetObjectList[name] else {return}
        let nodePosition = arSceneView.projectPoint(node.position)
        let nodeScreenPos = nodePosition.toCGPoint()
        let distanceToCenter = circleCenter.distanceTo(nodeScreenPos)
        
        universeModeViewModel.searchMode(selectPlanetName: name)
        
        if nodePosition.z >= 1 {
            // 찾는 노드가 뒤에 있을 때
            setNotDetectedLayout()
            setArrowLayout(point: nodeScreenPos, locatedBehind: true)
        } else if distanceToCenter >= (screenWidth / 3) {
            // 찾는 노드가 원의 바깥에 있을 때
            setNotDetectedLayout()
            setArrowLayout(point: nodeScreenPos)
        } else {
            // 찾는 노드가 원 안에 있을 때
            let nodeOrigin = CGPoint(x: nodeScreenPos.x - screenWidth / 11.3, y: nodeScreenPos.y - screenWidth / 11.3)
            setArrowHidden()
            setDetectedLayout(name: name, point: nodeOrigin)
            
            universeModeViewModel.updateAnnounceCardinal(.None)
            universeModeViewModel.updateDetectedNodeName(name)
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
            audioSource.volume = AudioVolume.half.volume
            audioSource.loops = true
            audioSource.load()
            
            let scnPlayer = SCNAudioPlayer(source: audioSource)
            
            planetNodes[index].removeAllAudioPlayers()
            planetNodes[index].addAudioPlayer(scnPlayer)
            
            var planetObjectSound: [String: SCNAudioPlayer] = [:]
            planetObjectSound[planet.name] = scnPlayer
            universeModeViewModel.sceneKitAudioVolumeManager.setSoundPlayer(planetObjectSound)
            
            return planetNodes[index]
        }
    }
}

// TODO: - 오류가 나지 않기 위해 실행을 위한 메서드 (VM 으로 바꾸어야 합니다.)
extension UniverseMainViewController {
    private func setArrowHidden() {
        DispatchQueue.main.async {
            self.guideArrowView.isHidden = true
        }
    }
    
    // 검색 시 화살표 레이아웃 설정
    private func setArrowLayout(point: CGPoint, locatedBehind: Bool = false) {
        var radian = locatedBehind ? atan2(circleCenter.y - point.y, point.x - circleCenter.x)
        + .pi : atan2(circleCenter.y - point.y, point.x - circleCenter.x)
        var degree = radian.radiansToDegree
        
        if locatedBehind {
            if degree > 45 && degree <= 90 {
                degree = 45
            } else if degree > 90 && degree < 135 {
                degree = 135
            } else if degree > 225 && degree < 270 {
                degree = 225
            } else if degree < 315 && degree >= 270 {
                degree = 315
            }
            radian = degree.degreeToRadians
        }
        
        let dx = screenWidth / 3  * cos(radian)
        let dy = screenWidth / 3  * sin(radian)
        let arrowPosition = CGPoint(x: circleCenter.x + dx, y: circleCenter.y - dy)
        
        universeModeViewModel.updateArrowCardinal(universeModeViewModel.getCardinal(angle: degree))

        DispatchQueue.main.async {
            self.guideArrowView.transform = CGAffineTransform(rotationAngle: -radian)
            self.guideArrowView.layer.position = arrowPosition
            self.guideArrowView.isHidden = false
        }
    }
    
    private func setModeChangedLayout(newMode: Mode) {
        self.navigationController?.topViewController?.title = newMode.titleText
        switch newMode {
        case .explore:
            setArrowHidden()
            universeModeViewModel.updateAnnounceCardinal(.None)
        case .search(planet: _):
            universeModeViewModel.updateAnnounceCardinal(.None)
        }
    }
    
    // 행성이 탐지되지 않았을 때 레이아웃 설정
    private func setNotDetectedLayout() {
        universeModeViewModel.updateDetectedNodeName("")
        DispatchQueue.main.async {
            self.guideCircleView.isHidden = false
            self.selectedSquareView.isHidden = true
        }
    }
    
    // 행성이 탐지되었을 때 레이아웃 설정
    private func setDetectedLayout(name: String, point: CGPoint) {
        DispatchQueue.main.async { [self] in
            
            let localizedDetectedNode = Planet(from: name.lowercased())?.planetName
            
            self.selectedSquareView.frame.origin = point
            self.selectedSquareView.planetLabel.text = localizedDetectedNode

            self.guideCircleView.isHidden = true
            self.selectedSquareView.isHidden = false
            self.selectedSquareView.isAccessibilityElement = true
            
            // 추후 사용예정 주석
            // self.selectedSquareView.accessibilityLabel = planetNameDict[name] ?? name
        }
    }
    
    // 행성 detect되었을 때 announce
    private func guideDetectedAnnounce(name: String) {
        UIAccessibility.post(notification: .layoutChanged, argument: selectedSquareView)
        UIAccessibility.post(notification: .announcement,
                             argument: name)
        HapticManager.instance.hapticImpact(style: .soft)
        PlanetManager.shared.currentPlanet = Planet(from: name.lowercased())
    }
    
    /// 화살표 변경시 가이드 음성
    private func guideAnnounce(_ newCardinal: Cardinal) {
        let announcementText = "\(newCardinal.directionText)"
        Task {
            try await Task.sleep(nanoseconds: 100)
            UIAccessibility.post(notification: .announcement, argument: announcementText)
        }
    }
}

// MARK: - Binding Methods

private extension UniverseMainViewController {
    
    /// User의 현재 위치 사용 권한 여부를 확인합니다.
    private func setUpAuthorizationBinding() {
        universeLocationViewModel.$isAuthorized
            .sink { [weak self] isAuthorized in
                if isAuthorized {
                    self?.showOnboarding()
                }
            }
            .store(in: &cancellables)
    }
    
    private func setUpBodiesBinding() {
        universeLocationViewModel.$bodies
            .sink { [weak self] _ in
                self?.setUpPlanetBinding()
            }
            .store(in: &cancellables)
    }

    func setUpNetworkState() {
        universeLocationViewModel.$isSuccess
            .sink { [weak self] success in
                if let success = success {
                    if success {
                        self?.showOnboarding()
                        print("성공해서 onboarding 화면을 숨깁니다")
                    } else {
                        self?.showNetworkSettingsAlert()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func setUpShowSettingBindidng() {
        
        universeLocationViewModel.$showSettingAlert
            .sink { [weak self] showAlert in
                if showAlert {
                    self?.showLocationSettingsAlert()
                }
            }
            .store(in: &cancellables)
        universeLocationViewModel.updateLocation()
    }

    func showOnboarding() {
        Task {
            await MainActor.run {
                self.onboardingView.isAccessibilityElement = false
                self.onboardingView.removeFromSuperview()
                self.navigationController?.navigationBar.layer.zPosition = 0
//                self.navigationController?.navigationBar.layer.zPosition = 1
                
                // UIAccessibility.post(notification: .layoutChanged, argument: self.sceneView)
                
                self.navigationController?.isNavigationBarHidden = false
                self.navigationController?.topViewController?.title = LocalizableKeys.exploreUniverseNavigationTitle.localized
                self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white]
                self.navigationController?.navigationBar.backgroundColor = .black
                
                let backBarButtonItem = UIBarButtonItem(title: self.navigationItem.title, style: .plain, target: self, action: nil)
                self.navigationItem.backBarButtonItem = backBarButtonItem
                backBarButtonItem.tintColor = .customYellow
                
                self.navigationItem.rightBarButtonItem?.tintColor = .white
                self.navigationItem.hidesBackButton = true
            }
        }
    }
    
    func showLocationSettingsAlert() {
        let alert = UIAlertController(title: LocalizableKeys.locationUsageMessage.localized,
                                      message: LocalizableKeys.locationAuthRequest.localized,
                                      preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: LocalizableKeys.defaultAction.localized, style: .default, handler: { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            DispatchQueue.main.async {
                UIApplication.shared.open(url)
            }
        })
        let destructiveAction = UIAlertAction(title: LocalizableKeys.cancel.localized, style: .destructive, handler: nil)
        
        alert.addAction(destructiveAction)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showNetworkSettingsAlert() {
        let alert = UIAlertController(title: LocalizableKeys.networkTitle.localized,
                                      message: LocalizableKeys.networkUsageMessage.localized,
                                      preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    func configureModeBinding() {
        universeModeViewModel.modeStateSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newMode in
                self?.setModeChangedLayout(newMode: newMode)
            }
            .store(in: &cancellables)
    
        universeModeViewModel.detectedNodeSubject
            .receive(on: DispatchQueue.main)
            .scan(("", "")) { (old, new) in (old.1, new) }
            .filter { oldValue, newValue in
                oldValue != newValue && !newValue.isEmpty
            }
            .map { $0.1 }
            .sink { [weak self] detectedNodeName in
                self?.guideDetectedAnnounce(name: detectedNodeName)
            }
            .store(in: &cancellables)
        
        universeModeViewModel.arrowCardinalSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newCardinal in
                self?.guideAnnounce(newCardinal)
            }
            .store(in: &cancellables)
    }
}

// MARK: - 행성의 위치 좌표 및 AR 노드 생성
private extension UniverseMainViewController {
    
    func setUpPlanetBinding() {
        universeLocationViewModel.$bodies
            .sink { [weak self] planets in
                guard let self = self else { return }
                let planetSpheres = self.makePlanetSphere(planets: planets)
                let planetNodes = self.makePlanetNode(planets: planets, planetSpheres: planetSpheres)
                self.setupPlanetPosition(to: self.arSceneView.scene, planetNodes: planetNodes)
                self.addAudioToPlanetNode(planets: planets, planetNodes: planetNodes)
            }
            .store(in: &cancellables)
    }
    
    func updateSceneWithNodes(_ nodes: [SCNNode]) {
        arSceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        for node in nodes {
            arSceneView.scene.rootNode.addChildNode(node)
        }
    }
}
