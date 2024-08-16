//
//  Mode.swift
//  Tars
//
//  Created by ParkJunHyuk on 8/9/24.
//

import Foundation

enum Mode {
    case explore
    case search(planet: String)
    
    var titleText: String {
        switch self {
        case .explore:
                return LocalizableKeys.exploreUniverseNavigationTitle.localized
        case .search(planet: let name):
                return LocalizableKeys.searchingNavigationTitle.localized
        }
    }
}
