//
//  UserDefaults+Extension.swift
//  Tars
//
//  Created by Seik Oh on 15/11/2022.
//

import Foundation

enum TextLiteral {
    static var checkedOnboarding: String { return "checkedOnboarding"}
}

extension UserDefaults {
    var checkedOnboarding: Bool? {
        get {
            let count = UserDefaults.standard.bool(forKey: TextLiteral.checkedOnboarding)
            return count
        }
        set {
            UserDefaults.standard.set(newValue, forKey: TextLiteral.checkedOnboarding)
        }
    }
}
