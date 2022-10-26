//
//  UniverseViewController.swift
//  Tars
//
//  Created by Lena on 2022/10/22.
//

import UIKit
import CoreMotion
import SceneKit
import CoreLocation

class UniverseViewController: UIViewController {
    
    let motionManager = CMMotionManager()
    var deviceQuaternion: CMQuaternion?
    let skyboxImages = (1...6).map { UIImage(named: "sky\($0)") }
    public var guideCircleView = CustomCircleView()
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        // desiredAccurcy 는 위치의 정확도를 설정
        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.distanceFilter = kCLHeadingFilterNone ?? 뭔지 모름
        manager.delegate = self
        return manager
    }()
    
    /// 3D 배경 세팅을 위한 sceneView 선언
    lazy var sceneView: SCNView = {
        let sceneView = SCNView()
        let backgroundSceneView = SCNScene(named: "UniverseBackground.scn")
        sceneView.scene = backgroundSceneView
        sceneView.scene?.background.contents = skyboxImages
        
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3Make(0, 0, 0) // set your camera position
        
        sceneView.scene?.rootNode.addChildNode(cameraNode)
        
        
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
            
//            locationManager.startUpdatingHeading()
            
        }
    }
    
    private func setPlanetPosition(to scene: SCNScene?, planets: [Body]) {
        
        for planet in planets {
            
            print(planet)
            
            if planet.name == "Earth" || planet.name == "Pluto" {
                continue
            } else {
                let sphere = SCNSphere(radius: 0.1)
                sphere.firstMaterial?.diffuse.contents = UIImage(named: planet.name)

                let sphereNode = SCNNode(geometry : sphere)
                sphereNode.worldPosition = SCNVector3(planet.coordinate!.x, planet.coordinate!.y, planet.coordinate!.z)
                
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

extension UniverseViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        // 자기 북쪽을 기준으로 하는 표제
        let userMagnetic = Int(newHeading.magneticHeading)
        
        // 진북쪽을 기준으로 하는 표제
        let userTrue = Int(newHeading.trueHeading)
        
        // 보고된 방향과 실제 지자기 방향 사이의 최대 편차 (도)
        let accuracy = Int(newHeading.headingAccuracy)
        
        // 최대 편차는 25에서 변하지 않음
//        print(userMagnetic, userTrue, accuracy)
        print("현재 방위 : ", userMagnetic)
        
        
        let sunAzimuth = 242
        
        
        if (userMagnetic >= sunAzimuth - 5) && (userMagnetic <= sunAzimuth + 5) {
            print("태양을 찾았습니다")
        }
        
    }

}
