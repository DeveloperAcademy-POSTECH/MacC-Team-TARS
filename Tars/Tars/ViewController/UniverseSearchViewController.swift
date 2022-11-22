//
//  UniverseSearchViewController.swift
//  Tars
//
//  Created by 김소현 on 2022/11/02.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

enum Mode {
    case explore
    case search(planet: String)
    
    var titleText: String {
        switch self {
        case .explore:
            return "우주 둘러보기"
        case .search(planet: let name):
            return "\(planetNameDict[name] ?? name) 찾는 중"
        }
    }
}

class UniverseSearchViewController: UIViewController, ARSCNViewDelegate, LocationManagerDelegate, UIGestureRecognizerDelegate {

    private var guideCircleView = CustomCircleView()
    private var selectedSquareView = CustomSquareView()
    private var guideArrowView = CustomArrowView()
    private var coachingOverlayView = CustomOnboardingOverlayView()
    private var coachingBackgroundOverlayView = CustomBackgroundOverlayView()
    let infoViewController = InfoViewController()
    
    // TapGesture 선언
    let selectedSquareViewTap = UITapGestureRecognizer()
    
    var mode: Mode = .explore {
        didSet {
            setModeChangedLayout()
        }
    }
    var planetObjectList: [String: SCNNode] = [:]
    var planetObjectSound: [String: SCNAudioPlayer] = [:]
    var circleCenter: CGPoint = .zero
    
    let searchGuideLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "빠르게 천체 찾기"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    public let selectPlanetCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = screenWidth * 0.05
        layout.minimumInteritemSpacing = CGFloat(UInt16.max)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SelectPlanetCollectionViewCell.self,
                                forCellWithReuseIdentifier: SelectPlanetCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: screenWidth * 0.09, bottom: 0, right: screenWidth * 0.09)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.backgroundColor = .black
        
        return collectionView
    }()
    
    /// ARKit 을 사용하기 위한 view 선언
    lazy var sceneView: ARSCNView = {
        let sceneView = ARSCNView()
        sceneView.delegate = self
        return sceneView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        coachingOverlayView.isAccessibilityElement = true
        coachingOverlayView.accessibilityLabel = PlanetStrings.onboardingInstructionstring.localizedKey
        UIAccessibility.post(notification: .layoutChanged, argument: coachingOverlayView)
        
        [guideCircleView, guideArrowView, selectedSquareView].forEach { sceneView.addSubview($0) }
        [coachingBackgroundOverlayView, coachingOverlayView, sceneView, selectPlanetCollectionView, searchGuideLabel].forEach { view.addSubview($0) }
        configureConstraints()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
            self.coachingOverlayView.isAccessibilityElement = false
            self.coachingOverlayView.removeFromSuperview()
            self.coachingBackgroundOverlayView.removeFromSuperview()
            self.navigationController?.navigationBar.layer.zPosition = 0
            
            // UIAccessibility.post(notification: .layoutChanged, argument: self.sceneView)
            
            // navigation title 설정
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.topViewController?.title = "우주 둘러보기"
            self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.backgroundColor = .black
            
            // settingButton navigationItem
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(self.settingButtonTapped))
            self.navigationItem.rightBarButtonItem?.tintColor = .white
            self.navigationItem.hidesBackButton = true
        }
        
        selectPlanetCollectionView.delegate = self
        selectPlanetCollectionView.dataSource = self
        
        selectedSquareView.isHidden = true
        guideArrowView.isHidden = true
        
        let locationManager = LocationManager.shared
        locationManager.delegate = self
        locationManager.updateLocation()
        
        // TapGesture와 View 연결
        selectedSquareViewTap.delegate = self
        selectedSquareViewTap.addTarget(self, action: #selector(squareViewTapped))
        selectedSquareView.addGestureRecognizer(selectedSquareViewTap)
    }
    
    // TapGesture 화면 전환 동작
    @objc func squareViewTapped() {
        // print(self.selectedSquareView.planetLabel.text ?? "nil")
        // infoViewController.planet.planetName = self.selectedSquareView.planetLabel.text ?? "Sun"
        self.navigationController?.pushViewController(infoViewController, animated: true)
    }
    
    @objc func settingButtonTapped() {
        self.navigationController?.pushViewController(SettingViewController(), animated: false)
    }
    
    /// 행성을 배치하기 위한 함수
    private func setPlanetPosition(to scene: SCNScene?, planets: [Body]) {
        for planet in planets {
            if planet.name == "Earth" || planet.name == "Pluto" {
                continue
            } else {
                let sphere = SCNSphere(radius: 0.2)
                sphere.firstMaterial?.diffuse.contents = UIImage(named: planet.name + "_Map")
                let sphereNode = SCNNode(geometry: sphere)
                sphereNode.position = SCNVector3(planet.coordinate.x, planet.coordinate.y, planet.coordinate.z)
                sphereNode.name = planet.name
                scene?.rootNode.addChildNode(sphereNode)
                planetObjectList[planet.name] = sphereNode
                
                let audioSource: SCNAudioSource = {
                    let source = SCNAudioSource(fileNamed: "Searching_\(planet.name).mp3")!
                    /// 노드와 해당 위치에와 소스의 볼륨, 반향 및 거리에 따라 자동으로 변경
                    source.isPositional = true
                    source.volume = 0.5
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
    
    private func configureConstraints() {
        sceneView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTop: screenHeight * 0.1)
        
        coachingOverlayView.layer.zPosition = 2
        coachingOverlayView.centerX(inView: view)
        coachingOverlayView.anchor(top: view.topAnchor, paddingTop: screenHeight * 0.23)
        
        coachingBackgroundOverlayView.layer.zPosition = 1
        self.navigationController?.navigationBar.layer.zPosition = -1

        guideCircleView.centerX(inView: view)
        guideCircleView.anchor(top: view.topAnchor, paddingTop: screenHeight * 0.23)
        
        searchGuideLabel.centerX(inView: view)
        searchGuideLabel.anchor(top: view.topAnchor, paddingTop: screenHeight * 0.7)

        selectPlanetCollectionView.anchor(top: view.topAnchor, paddingTop: screenHeight * 0.68)
        selectPlanetCollectionView.setHeight(height: screenHeight * 0.35)
        selectPlanetCollectionView.setWidth(width: screenWidth)
        selectPlanetCollectionView.centerX(inView: view)
        
        selectedSquareView.frame = CGRect(x: 0, y: 0, width: screenWidth / 5.65, height: (screenWidth / 5.65) + (screenHeight / 26.375))
        guideArrowView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravityAndHeading
        sceneView.session.run(configuration)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        circleCenter = guideCircleView.center
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    // MARK: - LocationManagerDelegate
    func didUpdateUserLocation() {
        Task {
            let bodies = try await AstronomyAPIManager().requestBodies()
            setPlanetPosition(to: sceneView.scene, planets: bodies)
        }
    }
    
    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        switch mode {
        case .explore:
            explore()
        case .search(planet: let name):
            search(for: name)
        }
    }
}

// MARK: - 레이아웃 설정 함수
extension UniverseSearchViewController {
    // 모드 변경에 따른 레이아웃 설정
    private func setModeChangedLayout() {
        self.navigationController?.topViewController?.title = mode.titleText
        switch mode {
        case .explore:
            setArrowHidden()
        case .search(planet: _):
            break
        }
    }
    
    // 행성이 탐지되지 않았을 때 레이아웃 설정
    private func setNotDetectedLayout() {
        DispatchQueue.main.async {
            self.guideCircleView.isHidden = false
            self.selectedSquareView.isHidden = true
        }
    }

    // 행성이 탐지되었을 때 레이아웃 설정
    private func setDetectedLayout(name: String, point: CGPoint) {
        DispatchQueue.main.async {
            self.selectedSquareView.frame.origin = point
            self.selectedSquareView.setLabel(planetNameDict[name] ?? name)
            self.guideCircleView.isHidden = true
            self.selectedSquareView.isHidden = false
        }
    }
    
    // 검색 시 화살표 레이아웃 설정
    private func setArrowLayout(point: CGPoint, distance: CGFloat, locatedBehind: Bool = false) {
        let dx = screenWidth / 3  * (point.x - circleCenter.x) / distance
        let dy = screenWidth / 3  * (circleCenter.y - point.y) / distance
        let angle = locatedBehind ? atan2(point.y - circleCenter.y, point.x - circleCenter.x) + .pi : atan2(point.y - circleCenter.y, point.x - circleCenter.x)
        let arrowPosition = locatedBehind ? CGPoint(x: circleCenter.x - dx, y: circleCenter.y + dy) : CGPoint(x: circleCenter.x + dx, y: circleCenter.y - dy)
                
        DispatchQueue.main.async {
            self.guideArrowView.transform = CGAffineTransform(rotationAngle: angle)
            self.guideArrowView.layer.position = arrowPosition
            self.guideArrowView.isHidden = false
        }
    }
    
    // 화살표 숨김 설정
    private func setArrowHidden() {
        DispatchQueue.main.async {
            self.guideArrowView.isHidden = true
        }
    }
}

extension UniverseSearchViewController {
    // MARK: - 탐색 모드 기능
    private func explore() {
        var detectNode: SCNNode?
        var nodeCenter: CGPoint = .zero
        var minDistance: CGFloat = screenHeight

        guard let pointOfView = sceneView.pointOfView else { return }
        let detectNodes = sceneView.nodesInsideFrustum(of: pointOfView) // 화면에 들어온 노드 리스트
        
        for node in detectNodes {
            let nodePosition = sceneView.projectPoint(node.position)
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
            guard let planetName = detectNode.name else { return }
            guard let name = planetNameDict[planetName] else { return }

            let nodeOrigin = CGPoint(x: nodeCenter.x - screenWidth / 11.3, y: nodeCenter.y - screenWidth / 11.3)
            setDetectedLayout(name: name, point: nodeOrigin)
            selectedExploreSoundPlay(soundPlayer: planetObjectSound, selectedName: planetName)
        } else {
            // 탐지된 노드가 없을 때
            setNotDetectedLayout()
            exploreModeSoundPlay(soundPlayer: planetObjectSound)
        }
    }
    
    // MARK: - 검색 모드 기능
    private func search(for name: String) {
        guard let node = planetObjectList[name] else {return}
        let nodePosition = sceneView.projectPoint(node.position)
        let nodeScreenPos = nodePosition.toCGPoint()
        let distanceToCenter = circleCenter.distanceTo(nodeScreenPos)
        
        selectModeSoundPlay(soundPlayer: planetObjectSound, selectedName: name)

        if nodePosition.z >= 1 {
            // 찾는 노드가 뒤에 있을 때
            setNotDetectedLayout()
            setArrowLayout(point: nodeScreenPos, distance: distanceToCenter, locatedBehind: true)
        } else if distanceToCenter >= (screenWidth / 3) {
            // 찾는 노드가 원의 바깥에 있을 때
            setNotDetectedLayout()
            setArrowLayout(point: nodeScreenPos, distance: distanceToCenter)
        } else {
            // 찾는 노드가 원 안에 있을 때
            let nodeOrigin = CGPoint(x: nodeScreenPos.x - screenWidth / 11.3, y: nodeScreenPos.y - screenWidth / 11.3)
            setArrowHidden()
            setDetectedLayout(name: name, point: nodeOrigin)
            
        }
    }
}

// MARK: - 모드에 따른 소리 증감 기능

extension UniverseSearchViewController {
    
    /// 탐색 모드일 때 - 모든 행성의 소리의 음량을 동일하게
    private func exploreModeSoundPlay(soundPlayer: [String: SCNAudioPlayer]) {
        
        for audioPlayer in soundPlayer.values {
            guard let avNode = audioPlayer.audioNode as? AVAudioMixing else { return }
            
            avNode.volume = 0.5
        }
    }
    
    /// 검색 모드일때 - 선택된 이외의 행성의 소리 음소거
    private func selectModeSoundPlay(soundPlayer: [String: SCNAudioPlayer], selectedName: String) {
        
        for name in soundPlayer.keys {
            if name == selectedName {
                let audioPlayer = soundPlayer[name]
                
                guard let avNode = audioPlayer?.audioNode as? AVAudioMixing else { return }
                
                avNode.volume = 0.5
            } else {
                let audioPlayer = soundPlayer[name]
                
                guard let avNode = audioPlayer?.audioNode as? AVAudioMixing else { return }
                
                avNode.volume = 0.0
            }
        }
    }
    
    /// 탐색된 행성 있을 때 - 탐색된 행성 소리는 증가 다른 행성은 감소
    private func selectedExploreSoundPlay(soundPlayer: [String: SCNAudioPlayer], selectedName: String) {
        
        for name in soundPlayer.keys {
            if name == selectedName {
                let audioPlayer = soundPlayer[name]
                
                guard let avNode = audioPlayer?.audioNode as? AVAudioMixing else { return }
                
                avNode.volume = 1.0
            } else {
                let audioPlayer = soundPlayer[name]
                
                guard let avNode = audioPlayer?.audioNode as? AVAudioMixing else { return }
                
                avNode.volume = 0.15
            }
        }
    }
}
