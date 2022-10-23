//
//  UniverseViewController.swift
//  Tars
//
//  Created by Lena on 2022/10/22.
//

import UIKit
import SceneKit

class UniverseViewController: UIViewController {
    
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
        view.addSubview(guideCircleView)
        
        sceneView.delegate = self
        sceneView.isPlaying = true
        
        [guideCircleView, sceneView].forEach { view.addSubview($0) }
        sceneView.addSubview(guideCircleView)
        configureConstraints()
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
