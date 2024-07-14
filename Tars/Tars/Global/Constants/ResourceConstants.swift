//
//  ResourceConstants.swift
//  Tars
//
//  Created by Lena on 2024/7/13.
//

import Foundation

enum ResourceConstants: String, CaseIterable {
    case mp3
    case wav
    case aif
    case usdz
    case Cube_002
    case map = "_Map"
    
    var name: String {
        return "\(rawValue)"
    }
    
}
