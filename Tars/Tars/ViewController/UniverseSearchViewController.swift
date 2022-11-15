//
//  UniverseSearchViewController.swift
//  Tars
//
//  Created by 김소현 on 2022/11/02.
//

import UIKit
import SceneKit
import ARKit

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

class UniverseSearchViewController: UIViewController, ARSCNViewDelegate, LocationManagerDelegate {

    private var guideCircleView = CustomCircleView()
    private var selectedSquareView = CustomSquareView()
    private var guideArrowView = CustomArrowView()
    let contentsViewController = ContentsViewController()
    
    var mode: Mode = .explore {
        didSet {
            setNeedsLayout()
        }
    }
    var planetObjectList: [SCNNode] = []
    
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
        selectPlanetCollectionView.delegate = self
        selectPlanetCollectionView.dataSource = self
        
        [guideCircleView, guideArrowView, selectedSquareView].forEach { sceneView.addSubview($0) }
        [sceneView, selectPlanetCollectionView, searchGuideLabel].forEach { view.addSubview($0) }
        configureConstraints()
        
        selectedSquareView.isHidden = true
        guideArrowView.isHidden = true
        
        let locationManager = LocationManager.shared
        locationManager.delegate = self
        locationManager.updateLocation()
        
        // navigation title 설정
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.topViewController?.title = "우주 둘러보기"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.backgroundColor = .black
        
        // settingButton navigationItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(settingButtonTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    @objc func settingButtonTapped() {
        self.navigationController?.pushViewController(SettingViewController(), animated: false)
    }
    
    /// 행성을 리스트에 저장하기 위한 함수
    private func getPlanetNodeList(planets: [Body]) {
        for planet in planets {
            if planet.name != "Earth" && planet.name != "Pluto" {
                let sphere = SCNSphere(radius: 0.2)
                let sphereNode = SCNNode(geometry: sphere)
                sphereNode.position = SCNVector3(planet.coordinate.x, planet.coordinate.y, planet.coordinate.z)
                planetObjectList.append(sphereNode)
            }
        }
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
                scene?.rootNode.addChildNode(sphereNode)
            }
        }
    }
    
    private func configureConstraints() {
        sceneView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTop: screenHeight * 0.1)
        
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    private func setNeedsLayout() {
        // TODO: - 모드 변경에 따른 레이아웃 설정
    }

    // MARK: - LocationManagerDelegate
    func didUpdateUserLocation() {
        Task {
            let bodies = try await AstronomyAPIManager().requestBodies()
            setPlanetPosition(to: sceneView.scene, planets: bodies)
            getPlanetNodeList(planets: bodies)
        }
    }
}
