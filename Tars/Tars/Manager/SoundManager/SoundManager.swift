//
//  SoundManager.swift
//  Tars
//
//  Created by Lena on 2022/11/26.
//

import Foundation
import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    var audioPlayer: AVAudioPlayer?
    
    init() {}
    
    public func playAudio(pre: String = AudioMode.search.prefix,
                          fileName: String,
                          audioExtension: String,
                          audioVolume: Float,
                          isLoop: Bool = true) {
        guard let url = Bundle.main.url(forResource: "\(pre)\(fileName)", withExtension: "\(audioExtension)") else { return }
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
            
            audioPlayer?.prepareToPlay()
            audioPlayer?.volume = audioVolume
            audioPlayer?.play()
            if isLoop {
                audioPlayer?.numberOfLoops = -1
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func playDetectingAudio(fileName: String) {
        guard let url = Bundle.main.url(forResource: "\(fileName)", withExtension: "wav") else { return }
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
            
            audioPlayer?.prepareToPlay()
            audioPlayer?.volume = 0.3
            audioPlayer?.play()
            
        } catch {
            print(error.localizedDescription)
        }
    }

    public func pauseAudio() {
        audioPlayer?.pause()
    }
}
