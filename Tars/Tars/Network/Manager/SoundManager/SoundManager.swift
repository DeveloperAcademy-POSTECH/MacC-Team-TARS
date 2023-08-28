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
    
    public func playAudio(pre: String = "Searching_",
                          fileName: String = "Jupiter",
                          audioExtension: String = "mp3",
                          audioVolume: Float = 0.7,
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

    public func pauseAudio() {
        audioPlayer?.pause()
    }
}
