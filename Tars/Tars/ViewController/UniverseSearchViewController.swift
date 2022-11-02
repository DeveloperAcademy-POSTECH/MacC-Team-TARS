//
//  UniverseSearchViewController.swift
//  Tars
//
//  Created by 김소현 on 2022/11/02.
//

import UIKit
import SceneKit
import ARKit

class UniverseSearchViewController: UIViewController, ARSCNViewDelegate, LocationManagerDelegate {

    public var guideCircleView = CustomCircleView()
    public var selectedSquareView = CustomSquareView()
    var planetObjectList: [SCNNode] = []
    
    let contentsViewController = ContentsViewController()
    
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
        collectionView.backgroundColor = .clear
        
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
        
        [guideCircleView, sceneView, selectedSquareView, selectPlanetCollectionView].forEach { view.addSubview($0) }
        sceneView.addSubview(guideCircleView)
        configureConstraints()
        
        selectedSquareView.isHidden = true
        
        let locationManager = LocationManager.shared
        locationManager.delegate = self
        locationManager.updateLocation()
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
        sceneView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        selectedSquareView.centerX(inView: sceneView)
        selectedSquareView.centerY(inView: sceneView)
        
        guideCircleView.centerX(inView: view)
        guideCircleView.centerY(inView: view)
        
        selectPlanetCollectionView.anchor(top: view.topAnchor, paddingTop: screenHeight * 0.70)
        selectPlanetCollectionView.setHeight(height: screenHeight * 0.35)
        selectPlanetCollectionView.setWidth(width: screenWidth)
        selectPlanetCollectionView.centerX(inView: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.worldAlignment = .gravityAndHeading

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
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

extension UniverseSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = screenWidth * 0.27
        let cellHeight = screenHeight * 0.17
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension UniverseSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planetList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectPlanetCollectionViewCell.identifier, for: indexPath) as? SelectPlanetCollectionViewCell else { return UICollectionViewCell() }
        
        let selectedPlanetName = planetList[indexPath.row].planetName
        let selectedPlanetImage = planetList[indexPath.row].planetImage
        
        cell.planetNameLabel.text = selectedPlanetName
        cell.planetImageView.image = selectedPlanetImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectPlanetCollectionViewCell.identifier, for: indexPath) as? SelectPlanetCollectionViewCell
        
        let selectedPlanet = planetList[indexPath.row]
        
        if (cell?.isSelected) != nil {
            contentsViewController.planet = selectedPlanet
            navigationController?.pushViewController(contentsViewController, animated: true)
        }
    }
}
