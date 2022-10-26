//
//  UniverseViewController.swift
//  Tars
//
//  Created by Lena on 2022/10/22.
//

import UIKit
import CoreMotion
import SceneKit

class UniverseViewController: UIViewController {
    
    let motionManager = CMMotionManager()
    var deviceQuaternion: CMQuaternion?
    let skyboxImages = (1...6).map { UIImage(named: "sky\($0)") }
    public var guideCircleView = CustomCircleView()
    public var selectedSquareView = CustomSquareView()
    
    /// 3D 배경 세팅을 위한 sceneView 선언
    lazy var sceneView: SCNView = {
        let sceneView = SCNView()
        let backgroundSceneView = SCNScene(named: "UniverseBackground.scn")
        sceneView.scene = backgroundSceneView
        sceneView.scene?.background.contents = skyboxImages
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.allowsCameraControl = true
        return sceneView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        sceneView.delegate = self
        sceneView.isPlaying = true
        
        [guideCircleView, sceneView, selectedSquareView].forEach { view.addSubview($0) }
        sceneView.addSubview(selectedSquareView)
        detectDeviceMotion()
        configureConstraints()
        
        Task {
            let bodies = try await AstronomyAPIManager().fetchBodies()
            setPlanetPosition(to: sceneView.scene, planets: bodies)
        }
    }
    
    // 행성을 배치하기 위한 함수
    private func setPlanetPosition(to scene: SCNScene?, planets: [Body]) {
        
        for planet in planets {
            
            print(planet)
            
            if planet.name == "Earth" || planet.name == "Pluto" {
                continue
            } else {
                let sphere = SCNSphere(radius: 0.07)
                sphere.firstMaterial?.diffuse.contents = UIImage(named: planet.name)

                let sphereNode = SCNNode(geometry : sphere)
                sphereNode.position = SCNVector3(planet.coordinate.x, planet.coordinate.y, planet.coordinate.z)

                scene?.rootNode.addChildNode(sphereNode)
            }
        }
    }
       
    private func detectDeviceMotion() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1/30.0
            motionManager.startDeviceMotionUpdates(using: .xArbitraryZVertical,
                                                   to: OperationQueue(),
                                                   withHandler: { (deviceMotion, _) in
                guard let data = deviceMotion else { return }
                self.deviceQuaternion = data.attitude.quaternion
            })
        }
    }
    
    private func configureConstraints() {
        guideCircleView.translatesAutoresizingMaskIntoConstraints = false
        selectedSquareView.translatesAutoresizingMaskIntoConstraints = false
        selectedSquareView.centerX(inView: sceneView)
        selectedSquareView.centerY(inView: sceneView)
        
        NSLayoutConstraint.activate([
            sceneView.widthAnchor.constraint(equalTo: view.widthAnchor),
            sceneView.heightAnchor.constraint(equalTo: view.heightAnchor),
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            guideCircleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            guideCircleView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension UniverseViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didApplyAnimationsAtTime time: TimeInterval) {
       if let q = self.deviceQuaternion {
          let quaternion = SCNQuaternion(q.x, q.y, q.z, q.w)
           sceneView.scene?.rootNode.orientation = quaternion
       }
    }
}
