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
    }
       
    private func detectDeviceMotion() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1/30.0
            motionManager.startDeviceMotionUpdates(using: .xArbitraryZVertical,
                                                   to: OperationQueue(),
                                                   withHandler: { (deviceMotion, error) in
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
          let quaternion = SCNQuaternion(q.y, -q.x, -q.z, q.w)
           sceneView.scene?.rootNode.orientation = quaternion
       }
    }
}
