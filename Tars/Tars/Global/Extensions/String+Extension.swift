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
        if self.range(of: "$") != nil {
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
    
    /// 원하는 언어에 따라 localize 하는 메서드
    /// - Parameter language: .english / .korean 입력에 따라 원하는 언어로 localize 가능 / 입력하지 않으면 시스템언어 
    func localized(for language: Language? = nil) -> String {
        let languageCode: String
        
        if let language = language {
            languageCode = language.rawValue
        } else {
            let preferredLanguage = Locale.preferredLanguages.first ?? "en"
            
            languageCode = preferredLanguage.components(separatedBy: "-").first ?? "en"
        }
        
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return NSLocalizedString(self, comment: "")
        }

        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
 }
