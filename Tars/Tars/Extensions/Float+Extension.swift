//
//  Float+Extension.swift
//  Tars
//
//  Created by 이윤영 on 2022/10/26.
//

import Foundation

extension Float {
    var degreeToRadian: Self { self * .pi / 180 }
}

extension FloatingPoint {
    var radiansToDegree: Self { self * 180 / .pi }
}
