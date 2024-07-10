//
//  String+Extension.swift
//  Tars
//
//  Created by 이윤영 on 2022/10/24.
//

import Foundation

extension String {
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func extractCoord() -> (String, String) {
        if let range = self.range(of: "$") {
            let firstS = self.firstIndex(of: "$")!
            let lastS = self.lastIndex(of: "$")!
            let firstExtraction = self[firstS..<lastS]
            let arr = firstExtraction.split(separator: "\n")
            let main = arr[1].split(separator: " ")
            
            return (String(main[3]), String(main[4]))
            
        } else {
            return (self, self)
        }
    }
    
    /// for localization language selection
    func localized(for locale: Locale = .current) -> String {
        guard let path = Bundle.main.path(forResource: locale.identifier, ofType: "lproj"),
                let bundle = Bundle(path: path) else {
            return NSLocalizedString(self, comment: "")
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
