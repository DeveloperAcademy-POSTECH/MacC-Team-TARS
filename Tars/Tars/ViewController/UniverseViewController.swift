//
//  UniverseViewController.swift
//  Tars
//
//  Created by Lena on 2022/10/22.
//

import UIKit
import SceneKit
import ARKit
import PHASE

class UniverseViewController: UIViewController, ARSCNViewDelegate, LocationManagerDelegate {
    
    public var guideCircleView = CustomCircleView()
    public var selectedSquareView = CustomSquareView()
    var phaseEngine: PHASEEngine!
    
    /// ARKit 을 사용하기 위한 view 선언
    lazy var sceneView: ARSCNView = {
        let sceneView = ARSCNView()
        sceneView.delegate = self
        return sceneView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        [guideCircleView, sceneView, selectedSquareView].forEach { view.addSubview($0) }
        sceneView.addSubview(guideCircleView)
        configureConstraints()
        
        selectedSquareView.isHidden = true
        
        let locationManager = LocationManager.shared
        locationManager.delegate = self
        locationManager.updateLocation()
        
        /*  자동 업데이트 모드에서 phaseEngine 생성
            게임에서 프레임 업데이트와 정확한 동기화가 필요한 경우 수동모드 선택이 좋다
        */
        self.phaseEngine = PHASEEngine(updateMode: .automatic)
        
//        let phaseListener = PHASEListener(engine: phaseEngine)
//        try! self.phaseEngine.rootObject.addChild(phaseListener)
//
//        let fileName = "Mars"
//        let url = Bundle.main.url(forResource: fileName, withExtension: "mp3")!
//
//        try! phaseEngine.assetRegistry.registerSoundAsset(url: url, identifier: "Mars", assetType: .resident, channelLayout: nil, normalizationMode: .dynamic)
//
//        let samplerNodeDefinition = PHASESamplerNodeDefinition(soundAssetIdentifier: "Mars", mixerDefinition: phaseSpatialMixerDefinition!)
//
//        samplerNodeDefinition.playbackMode = .looping
//        samplerNodeDefinition.setCalibrationMode(calibrationMode: .relativeSpl, level: 12)
        
        
        // 애플리케이션 번들에 저장된 오디오 파일의 URL 검색
//        let audioFileUrl = Bundle.main.url(forResource: "Mars", withExtension: "mp3")!
//
//        // identifier : 나중에 참조할 수 있도록 사운드 assets 에 고유한 이름을 지정
//        // assetType : 실시간으로 메모리오 스트리밍 하는 것이 아닌 resident 메모리에 미리 로드 되어야 한다고 지정
//        // normalizationMode : 출력장치에서 보정된 음량에 대한 사운드 자산을 정규화하도록 선택, 일반적으로 입력을 정규화하는 것이 좋음, Sampler 에 컨텐츠를 할당하고 출력 레벨을 설정하면 컨텐츠를 더 쉽게 혼합할 수 있게 된다
//        let soundAsset = try phaseEngine.assetRegistry.registerSoundAsset(url: audioFileUrl, identifier: "Mars", assetType: .resident, channelLayout: nil, normalizationMode: .dynamic)
//
//        // 재생 모드는 Sampler 가 오디오 파일을 반복할지 여부를 설정, 보정 수준은 믹스 내에서 Sampler 의 인지된 음량을 설정
//        // Sampler 노드의 출력을 채널 믹서의 입력에 연결하고 몇가지 기본 매개변수를 설정 했으므로 사운드 이벤트 자산을 phaseEngine 에 등록할 차례
//
//        // 모노 레이아웃 태그에서 채널 레이아웃 생성
//        let channelLayout = AVAudioChannelLayout(layoutTag: kAudioChannelLayoutTag_Mono)!
//
//        // Mono 채널 레이아웃으로 채널 믹서를 초기화
//        let channelMixerDefinition = PHASEChannelMixerDefinition(channelLayout: channelLayout)
//
//        // 샘플러 노드를 생성 및 엔진에 등록한 모노 드럼 에셋을 참조하는 drums 이라는 이름을 전달
//        let samplerNodeDefinition = PHASESamplerNodeDefinition(soundAssetIdentifier: "Mars", mixerDefinition: channelMixerDefinition)
//
//        // 명시적으로 중지할 때 까지 사운드가 계속 재생
//        samplerNodeDefinition.playbackMode = .looping
//
//        // CalibrationMode 를 relativeSpl 로 설정 및 레벨을 0 데시벨로 설정 -> 경험을 위한 편안한 청취 수준을 보장
//        samplerNodeDefinition.setCalibrationMode(calibrationMode: .relativeSpl, level: 0)
//
//        // soundEventAsset 을 엔진에 등록 및 MarsEvent 로 전달하여 나중에 재생을 위한 사운드 이벤트 생성을 시작할 때 참조 가능
//        let soundEventAsset = try phaseEngine.assetRegistry.registerSoundEventAsset(rootNode: samplerNodeDefinition, identifier: "MarsEvent")
//
//        // 가장먼저 할 일은 이름이 MarsEvent 인 등록된 사운드 이벤트 자산에서 사운드 이벤트를 만드는 것
//        // 로드된 사운드 assets 은 샘플러를 통해재생, 채널 믹서로 라우팅되고 현재 출력형식으로 다시 매핑, 출력 장치를 통해 재생
//
//        // 사운드 이벤트 assets 은 등록된 사운드 assets 의 이름으로 구성
//        let soundEvent = try PHASESoundEvent(engine: phaseEngine, assetIdentifier: "MarsEvnet")
//
//        // 엔진을 시작하면 오디오 IO 가 시작되 고 사운드 이벤트가 시작
//        try phaseEngine.start()
//
//        try soundEvent.start()
        
        
        let spatialPipelineFlags : PHASESpatialPipeline.Flags = [.directPathTransmission, .lateReverb]
        let spatialPipeline = PHASESpatialPipeline(flags: spatialPipelineFlags)!
        spatialPipeline.entries[PHASESpatialCategory.lateReverb]!.sendLevel = 0.1
        phaseEngine.defaultReverbPreset = .mediumRoom
        
        let spatialMixerDefinition = PHASESpatialMixerDefinition(spatialPipeline: spatialPipeline)
        
//        let spatialMixerDefinition = PHASESpatialMixerDefinition(spatialPipeline: PHASESpatialPipeline(flags: .directPathTransmission)!)
        
        // 자연스겁게 들리는 GeometricSpreadingDistanceModel 을 만들어 공간 믹서에 할당
        let distanceModelParameters = PHASEGeometricSpreadingDistanceModelParameters()
        distanceModelParameters.fadeOutParameters = PHASEDistanceModelFadeOutParameters(cullDistance: 10.0)
        
        // rolloff 계수 : 거리에서 사운드 레벨이 감소하는 곡선의 가파른 정도를 제어
        // 값이 1.0 이면 거리가 두배 가 되어 레벨이 절반으로 줄어들고 높을수록 감쇠가 빨라지고 값이 낮을 수록 느려진다
        distanceModelParameters.rolloffFactor = 0.25
        spatialMixerDefinition.distanceModelParameters = distanceModelParameters
        
//        var marsPostion : simd_float4x4 = matrix_identity_float4x4
//
//        let marsSource = PHASESource(engine: phaseEngine)
//
//        do {
//            try phaseEngine.rootObject.addChild(marsSource)
//        } catch {
//            print("Failed to add a child object to the scene.")
//        }
        
    }
    
    // PHASE 를 명시적으로 중지
//    override func viewWillDisappear(_ animated: Bool) {
//              super.viewWillDisappear(animated)
//              self.phaseEngine.stop()
//    }
    
    /// 행성을 배치하기 위한 함수
    private func setPlanetPosition(to scene: SCNScene?, planets: [Body]) {
        
        for planet in planets {
            
            print(planet)
            
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
        }
    }
    
}
