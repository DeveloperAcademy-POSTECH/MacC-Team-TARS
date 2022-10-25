//
//  PlanetInfo.swift
//  Tars
//
//  Created by ParkJunHyuk on 2022/10/25.
//

import Foundation

enum Planet: String, CaseIterable {
    case mercury
    case venus
    case mars
    case jupiter
    case satrun
    case uranus
    case sun
    case moon
    
    var name: String {
      rawValue.prefix(1).capitalized + rawValue.dropFirst()
    }
    
}
