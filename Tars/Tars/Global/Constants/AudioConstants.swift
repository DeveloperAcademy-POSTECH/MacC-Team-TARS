//
//  AudioConstants.swift
//  Tars
//
//  Created by Lena on 2024/7/13.
//

import Foundation

enum AudioMode: String, CaseIterable {
    case search
    case detail
    case detected
    
    var prefix: String {
        switch self {
        case .search:
            return "Searching_"
        case .detail:
            return "Detail_"
        case .detected:
            return "Detecting_"
        }
    }
}

enum AudioVolume: CaseIterable {
    case max
    case half
    case third
    case tenth
    case mute
    
    var volume: Float {
        switch self {
        case .max:
            return 1.0
        case .half:
            return 0.5
        case .third:
            return 0.3
        case .tenth:
            return 0.1
        case .mute:
            return 0.0
        }
    }
}
