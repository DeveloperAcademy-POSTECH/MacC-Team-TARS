//
//  SCNVector3+Extension.swift
//  Tars
//
//  Created by 이윤영 on 2022/11/15.
//

import SceneKit

extension SCNVector3 {
    func toCGPoint() -> CGPoint {
        CGPoint(x: CGFloat(self.x), y: CGFloat(self.y))
    }
}
