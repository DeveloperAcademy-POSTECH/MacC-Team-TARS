//
//  PlanetContentsList.swift
//  Tars
//
//  Created by Ayden on 2022/11/23.
//

import Foundation

struct PlanetContentsList {
    let planetName: String
    let planetInfoFirstTitle: String
    let planetInfoFirstContents: String
    let planetInfoSecondTitle: String
    let planetInfoSecondContents: String
    let planetInfoLastTitle: String
    let planetInfoLastContents: String
    
    init(planetName: String, planetInfoFirstTitle: String, planetInfoFirstContents: String, planetInfoSecondTitle: String, planetInfoSecondContents: String, planetInfoLastTitle: String, planetInfoLastContents: String) {
        self.planetName = planetName
        self.planetInfoFirstTitle = planetInfoFirstTitle
        self.planetInfoFirstContents = planetInfoFirstContents
        self.planetInfoSecondTitle = planetInfoSecondTitle
        self.planetInfoSecondContents = planetInfoSecondContents
        self.planetInfoLastTitle = planetInfoLastTitle
        self.planetInfoLastContents = planetInfoLastContents
    }
    
    init(planetName: String) {
        self.planetName = planetName
        self.planetInfoFirstTitle = ""
        self.planetInfoFirstContents = ""
        self.planetInfoSecondTitle = ""
        self.planetInfoSecondContents = ""
        self.planetInfoLastTitle = ""
        self.planetInfoLastContents = ""
    }
}
