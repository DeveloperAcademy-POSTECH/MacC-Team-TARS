//
//  PlanetManager.swift
//  Tars
//
//  Created by Lena on 2024/7/13.
//

import Foundation
import Combine

class PlanetManager {
    static let shared = PlanetManager()
    
    @Published var currentPlanet: Planet?
    
    private init() { } 
}
