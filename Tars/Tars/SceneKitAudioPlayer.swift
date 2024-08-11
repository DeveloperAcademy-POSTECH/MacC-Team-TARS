//
//  SceneKitAudioPlayer.swift
//  Tars
//
//  Created by ParkJunHyuk on 8/11/24.
//

import Foundation
import SceneKit
import AVFAudio

protocol SceneKitAudioVolumeProtocol {
    func setSoundPlayer(_ soundPlayer: [String: SCNAudioPlayer])
    func setVolumeForAll(volume: Float)
    func setVolume(selectedName: String, selectedVolume: Float, otherVolume: Float)
}

class SceneKitAudioVolumeManager: SceneKitAudioVolumeProtocol {
    private var soundPlayer: [String: SCNAudioPlayer] = [:]
    
    // soundPlayer를 설정하는 메서드
    func setSoundPlayer(_ soundPlayer: [String: SCNAudioPlayer]) {
        self.soundPlayer = soundPlayer
    }
    
    // 모든 행성에 대한 볼륨 조절 메서드
    func setVolumeForAll(volume: Float) {
        for audioPlayer in soundPlayer.values {
            if let avNode = audioPlayer.audioNode as? AVAudioMixing {
                avNode.volume = volume
            }
        }
    }
    
    // 각 행성에 맞게 볼륨 조절 메서드
    func setVolume(selectedName: String, selectedVolume: Float, otherVolume: Float) {
        for (name, audioPlayer) in soundPlayer {
            guard let avNode = audioPlayer.audioNode as? AVAudioMixing else { continue }
            avNode.volume = (name == selectedName) ? selectedVolume : otherVolume
        }
    }
}
