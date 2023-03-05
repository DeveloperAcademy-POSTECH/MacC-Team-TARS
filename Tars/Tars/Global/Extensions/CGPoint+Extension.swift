//
//  CGPoint+Extension.swift
//  Tars
//
//  Created by 이윤영 on 2022/11/15.
//

import Foundation

extension CGPoint {
    func distanceTo(_ to: CGPoint) -> CGFloat {
        return sqrt((self.x - to.x) * (self.x - to.x) + (self.y - to.y) * (self.y - to.y))
    }
}
