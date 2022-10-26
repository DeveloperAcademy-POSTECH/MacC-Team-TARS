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
}
