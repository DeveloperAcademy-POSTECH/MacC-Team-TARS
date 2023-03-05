//
//  GuideCircleView.swift
//  Tars
//
//  Created by Lena on 2022/10/22.
//

import UIKit

extension UIView {
    public func addDashedCircle() {
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        circleLayer.lineWidth = 2.0
        circleLayer.strokeColor =  UIColor.customYellow.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineJoin = .round
        circleLayer.lineDashPattern = [15, 3]
        layer.addSublayer(circleLayer)
    }
}
