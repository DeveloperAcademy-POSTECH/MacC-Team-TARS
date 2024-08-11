//
//  UniverseModeViewModel.swift
//  Tars
//
//  Created by ParkJunHyuk on 8/9/24.
//

import Foundation
import Combine

final class UniverseModeViewModel {
    
    let sceneKitAudioVolumeManager: SceneKitAudioVolumeProtocol
    
    /// 현재 방위 정보를 갖고 있는 프로퍼티
    @Published private(set) var announceCardinal: Cardinal = .None

    /// explore, search  모드에 대한 Publisher
    let modeStateSubject = CurrentValueSubject<Mode, Never>(.explore)
    
    /// 감지 된 Node 에 대한 정보를 전달하는 Publisher
    let detectedNodeSubject = CurrentValueSubject<String, Never>("")
    
    /// 방위를 나타내는 Publisher
    let arrowCardinalSubject = CurrentValueSubject<Cardinal, Never>(.None)
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - init
    
    init(sceneKitAudioVolumeManager: SceneKitAudioVolumeProtocol) {
        self.sceneKitAudioVolumeManager = sceneKitAudioVolumeManager
        
        arrowCardinalSubject
            .filter { [weak self] newCardinal in
                guard let self = self else { return false }
                return !self.announceCardinal.isNear(new: newCardinal)
            }
            .assign(to: &$announceCardinal)
    }
    
    func getCardinal(angle: CGFloat) -> Cardinal {
        let angle = angle < 0 ? angle + 360 : angle
        
        if angle >= 22.5 && angle < 67.5 {
            return Cardinal.NE
        } else if angle >= 67.5 && angle < 112.5 {
            return Cardinal.N
        } else if angle >= 112.5 && angle < 157.5 {
            return Cardinal.NW
        } else if angle >= 157.5 && angle < 202.5 {
            return Cardinal.W
        } else if angle >= 202.5 && angle < 247.5 {
            return Cardinal.SW
        } else if angle >= 247.5 && angle < 292.5 {
            return Cardinal.S
        } else if angle >= 292.5 && angle < 337.5 {
            return Cardinal.SE
        } else if (angle >= 337.5 && angle < 360) || (angle >= 0 && angle < 22.5) {
            return Cardinal.E
        }
        
        return Cardinal.None
    }
}

extension UniverseModeViewModel {
    /// mode 변경을 위한 메서드
    func changeMode(newMode: Mode) {
        modeStateSubject.send(newMode)
    }
    
    /// detectedNode 의 값을 바꾸기 위한 메서드
    func updateDetectedNodeName(_ newValue: String) {
        detectedNodeSubject.send(newValue)
    }
    
    /// ArrowCardinal 의 값을 바꾸기 위한 메서드
    func updateArrowCardinal(_ newCardinal: Cardinal) {
        arrowCardinalSubject.send(newCardinal)
    }
    
    /// announceCardinal 의 값을 바꾸기 위한 메서드
    func updateAnnounceCardinal(_ newAnnouceCardinal: Cardinal) {
        announceCardinal = newAnnouceCardinal
    }
}

/// 음향을 조절하는 메서드
extension UniverseModeViewModel {

    /// 탐색 모드 시 음향 조절
    func exploreMode() {
        sceneKitAudioVolumeManager.setVolumeForAll(volume: AudioVolume.half.volume)
    }
    
    /// 탐색 모드에서 행성을 탐지 했을 때 음향 조절
    func selectedNodeExploreMode(selectPlanetName: String) {
        sceneKitAudioVolumeManager.setVolume(selectedName: selectPlanetName, selectedVolume: AudioVolume.max.volume, otherVolume: AudioVolume.tenth.volume)
    }
    
    /// 빠르게 천체 찾기 모드 시 음향 조절
    func searchMode(selectPlanetName: String) {
        sceneKitAudioVolumeManager.setVolume(selectedName: selectPlanetName, selectedVolume: AudioVolume.half.volume, otherVolume: AudioVolume.mute.volume)
    }
    
    /// 탐색, 검색화면에서의 음소거
    func muteAllNode() {
        sceneKitAudioVolumeManager.setVolumeForAll(volume: AudioVolume.mute.volume)
    }
}
