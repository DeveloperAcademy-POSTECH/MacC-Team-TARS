//
//  Cardinal.swift
//  Tars
//
//  Created by ParkJunHyuk on 8/9/24.
//

import Foundation

enum Cardinal: Int {
    case N = 0
    case NE = 1
    case E = 2
    case SE = 3
    case S = 4
    case SW = 5
    case W = 6
    case NW = 7
    case None
    
    func isNear(new: Cardinal) -> Bool {
        if new == .None {
            return true
        } else if self == .None {
            return false
        } else {
            let difference = abs(self.rawValue - new.rawValue) % 7
            return difference <= 1
        }
    }
    
    var directionText: String {
        switch self {
        case .N:
                return LocalizableKeys.directionUp.localized
        case .NE:
                return LocalizableKeys.directionUpRight.localized
        case .E:
                return LocalizableKeys.directionRight.localized
        case .SE:
                return LocalizableKeys.directionDownRight.localized
        case .S:
                return LocalizableKeys.directionDown.localized
        case .SW:
                return LocalizableKeys.directionDownLeft.localized
        case .W:
                return LocalizableKeys.directionLeft.localized
        case .NW:
                return LocalizableKeys.directionUpLeft.localized
        default:
            return ""
        }
    }
}
