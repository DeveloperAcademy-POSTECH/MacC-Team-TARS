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
    private var planetObjectSound: [String: SCNAudioPlayer] = [:]
    private var circleCenter: CGPoint = .zero
    private var universeLocationViewModel = UniverseLocationViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    var mode: Mode = .explore {
        didSet {
            setModeChangedLayout()
        }
    }
    
    var announceCardinal: Cardinal = .None
    
    private let planetCollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var planetListData = [PlanetInfo]()
    var selectedIndexPath: IndexPath?
    
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
                    planetName: $0.planetName,
                    planetImage: $0.nameEnglish,
                    isSelected: .notSelect
                )
            )
        }
        
        setUpAuthorizationBinding()
        showOnboarding()
        setUpShowSettingBindidng()
        setUpBodiesBinding()
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
        onboardingView.isAccessibilityElement = true
        onboardingView.accessibilityLabel = LocalizableKeys.onboardingInstructionstring.localized
        UIAccessibility.post(notification: .layoutChanged, argument: onboardingView)
        
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
/*
private extension UniverseMainViewController {
    
    func updateUserLocation() {
        Task {
//            let bodies = try await HorizonsAPIManager().requestBodies()
            
        }
    }
}
*/
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

// TODO: - 오류가 나지 않기 위해 실행을 위한 메서드 (VM 으로 바꾸어야 합니다.)
extension UniverseMainViewController {
    private func setArrowHidden() {
        DispatchQueue.main.async {
            self.guideArrowView.isHidden = true
        }
    }
    
    private func setModeChangedLayout() {
        self.navigationController?.topViewController?.title = mode.titleText
        switch mode {
        case .explore:
            setArrowHidden()
            announceCardinal = .None
        case .search(planet: _):
            announceCardinal = .None
        }
    }
    
    enum Mode {
        case explore
        case search(planet: String)
        
        var titleText: String {
            switch self {
            case .explore:
                    return LocalizableKeys.exploreUniverseNavigationTitle.localized
            case .search(planet: let name):
                    return LocalizableKeys.searchingNavigationTitle.localized
            }
        }
    }
    
    enum Cardinal: Int {
        case N = 0
        case NE = 1
        case E = 2
        case SE = 3
        case S = 4
        case SW = 5
        case W = 6
        case NW = 7
        case None
        
        func isNear(new: Cardinal) -> Bool {
            if new == .None {
                return true
            } else if self == .None {
                return false
            } else {
                let difference = abs(self.rawValue - new.rawValue) % 7
                return difference <= 1
            }
        }
        
        var directionText: String {
            switch self {
            case .N:
                    return LocalizableKeys.directionUp.localized
            case .NE:
                    return LocalizableKeys.directionUpRight.localized
            case .E:
                    return LocalizableKeys.directionRight.localized
            case .SE:
                    return LocalizableKeys.directionDownRight.localized
            case .S:
                    return LocalizableKeys.directionDown.localized
            case .SW:
                    return LocalizableKeys.directionDownLeft.localized
            case .W:
                    return LocalizableKeys.directionLeft.localized
            case .NW:
                    return LocalizableKeys.directionUpLeft.localized
            default:
                return ""
            }
        }
    }
    
    private func getCardinal(angle: CGFloat) -> Cardinal {
        let angle = angle < 0 ? angle + 360 : angle
        
        if angle >= 22.5 && angle < 67.5 {
            return Cardinal.NE
        } else if angle >= 67.5 && angle < 112.5 {
            return Cardinal.N
        } else if angle >= 112.5 && angle < 157.5 {
            return Cardinal.NW
        } else if angle >= 157.5 && angle < 202.5 {
            return Cardinal.W
        } else if angle >= 202.5 && angle < 247.5 {
            return Cardinal.SW
        } else if angle >= 247.5 && angle < 292.5 {
            return Cardinal.S
        } else if angle >= 292.5 && angle < 337.5 {
            return Cardinal.SE
        } else if (angle >= 337.5 && angle < 360) || (angle >= 0 && angle < 22.5) {
            return Cardinal.E
        }
        
        return Cardinal.None
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
            .sink { [weak self] bodies in
                self?.setPlanetPosition(to: self?.arSceneView.scene, planets: bodies)
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
            try await Task.sleep(nanoseconds: 5_000_000_000)
            
            await MainActor.run {
                self.onboardingView.isAccessibilityElement = false
                self.onboardingView.removeFromSuperview()
                self.navigationController?.navigationBar.layer.zPosition = 0
                
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
}

// MARK: - 행성의 위치 좌표 및 AR 노드 생성
private extension UniverseMainViewController {
    /*
    func setUpPlanetBinding() {
        planetViewModel.$planetData
            .sink { [weak self] planets in
                guard let self = self else { return }
                let planetSpheres = self.makePlanetSphere(planets: planets)
                let planetNodes = self.makePlanetNode(planets: planets, planetSpheres: planetSpheres)
                self.setupPlanetPosition(to: self.arSceneView.scene, planetNodes: planetNodes)
                self.addAudioToPlanetNode(planets: planets, planetNodes: planetNodes)
            }
            .store(in: &cancellables)
    }
    */
    
    /// 행성을 배치하기 위한 함수
    private func setPlanetPosition(to scene: SCNScene?, planets: [Body]) {
        for planet in planets {
            if !PlanetConstants.planetsEn.contains(planet.name) {
                continue
            } else {
                let sphere = SCNSphere(radius: 0.2)
                sphere.firstMaterial?.diffuse.contents = UIImage(named: planet.name + ResourceConstants.map.rawValue)
                let sphereNode = SCNNode(geometry: sphere)
                sphereNode.position = SCNVector3(planet.coordinate.x, planet.coordinate.y, planet.coordinate.z)
                sphereNode.name = planet.name
                scene?.rootNode.addChildNode(sphereNode)
                planetObjectList[planet.name] = sphereNode
                
                let audioSource: SCNAudioSource = {
                    let source = SCNAudioSource(fileNamed: "\(AudioMode.search.prefix)\(planet.name).\(ResourceConstants.mp3.name)")!
                    // TODO: 강제언래핑 제거하기
                    /// 노드와 해당 위치에와 소스의 볼륨, 반향 및 거리에 따라 자동으로 변경
                    source.isPositional = true
                    source.volume = AudioVolume.half.volume
                    /// 오디오 소스를 반복적으로 재상할지 여부를 결정
                    source.loops = true
                    source.load()
                    return source
                }()
                
                let scnPlayer = SCNAudioPlayer(source: audioSource)
                planetObjectSound[planet.name] = scnPlayer
                sphereNode.removeAllAudioPlayers()
                sphereNode.addAudioPlayer(scnPlayer)
            }
        }
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
