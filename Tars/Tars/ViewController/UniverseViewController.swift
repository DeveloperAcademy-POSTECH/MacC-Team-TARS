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
        
        [guideCircleView, sceneView].forEach { view.addSubview($0) }
        sceneView.addSubview(guideCircleView)
        detectDeviceMotion()
        configureConstraints()
        
        Task {
            let bodies = try await AstronomyAPIManager().fetchBodies()
            
            setPlanetPosition(to: sceneView.scene, planets: bodies)
//            print(bodies)
        }
        
//        let sphere3 = SCNSphere(radius: 1)
//        sphere3.firstMaterial?.diffuse.contents = UIImage(named: "jupiter")
//
//        let sphereNode3 = SCNNode(geometry : sphere3)
//        sphereNode3.position = SCNVector3(0.5, 5, -1)
//
//        sceneView.scene?.rootNode.addChildNode(sphereNode3)
        
    }
    
    private func setPlanetPosition(to scene: SCNScene?, planets: [Body]) {
        
        for planet in planets {
            
            
            print(planet.name)
        }
        
//        for planet in Planet.allCases {
//            let identifier = planet.rawValue
//
//            let sphere = SCNSphere(radius: 0.1)
//            sphere.firstMaterial?.diffuse.contents = UIImage(named: identifier)
//
//            let sphereNode = SCNNode(geometry : sphere)
//            sphereNode.position = SCNVector3(x, y, z)
//
//            scene?.rootNode.addChildNode(sphereNode)
//
//        }
    }
    
//    private func applyTextures(to scene: SCNScene?) {
//        // Planet 열거형을 통해 모든 행성을 나열
//        for planet in Planet.allCases {
//          // planet.rawValue 는 행성에 적용해온 식별자 (mercury, venus 등)
//          let identifier = planet.rawValue
//
//          let sphere = SCNSphere(radius: 0.1)
//
//          // 식별자를 사용하여 행성의 노드에 대한 참조
//          let node = scene?.rootNode
//            .childNode(withName: identifier, recursively: false)
//
//          // Assets 에 있는 이름도 행성의 식별자와 일치
//          let texture = UIImage(named: identifier)
//
//          // 이미지를 node의 재료에 행성의 duffuse 로 사용, 색상을 대체
//          node?.geometry?.firstMaterial?.diffuse.contents = texture
//        }
//    }

       
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
