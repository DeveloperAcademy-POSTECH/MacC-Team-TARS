//
//  PlanetContentsList.swift
//  Tars
//
//  Created by Ayden on 2022/11/23.
//

import Foundation

struct PlanetContent {
    var planetName: String
//    let planetInfoFirstTitle: String
//    let planetInfoFirstContents: String
//    let planetInfoSecondTitle: String
//    let planetInfoSecondContents: String
//    let planetInfoLastTitle: String
//    let planetInfoLastContents: String
    let planetTitle1: String
    let planetContents1: String
    let planetTitle2: String
    let planetContents2: String
    let planetTitle3: String
    let planetContents3: String
    
    init() {
        self.planetName = ""
        self.planetTitle1 = ""
        self.planetContents1 = ""
        self.planetTitle2 = ""
        self.planetContents2 = ""
        self.planetTitle3 = ""
        self.planetContents3 = ""
    }
//    init(planetName: String, planetInfoFirstTitle: String, planetInfoFirstContents: String, planetInfoSecondTitle: String, planetInfoSecondContents: String, planetInfoLastTitle: String, planetInfoLastContents: String) {
//        self.planetName = planetName
//        self.planetInfoFirstTitle = planetInfoFirstTitle
//        self.planetInfoFirstContents = planetInfoFirstContents
//        self.planetInfoSecondTitle = planetInfoSecondTitle
//        self.planetInfoSecondContents = planetInfoSecondContents
//        self.planetInfoLastTitle = planetInfoLastTitle
//        self.planetInfoLastContents = planetInfoLastContents
//    }
    init(planetName: String, planetTitle1: String, planetContents1: String, planetTitle2: String, planetContents2: String, planetTitle3: String, planetContents3: String) {
        self.planetName = planetName
        self.planetTitle1 = planetTitle1
        self.planetContents1 = planetContents1
        self.planetTitle2 = planetTitle2
        self.planetContents2 = planetContents2
        self.planetTitle3 = planetTitle3
        self.planetContents3 = planetContents3
    }
    
    init(planetName: String) {
        self.planetName = planetName
        self.planetTitle1 = ""
        self.planetContents1 = ""
        self.planetTitle2 = ""
        self.planetContents2 = ""
        self.planetTitle3 = ""
        self.planetContents3 = ""
    }
}
