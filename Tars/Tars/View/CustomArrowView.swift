//
//  CustomArrowView.swift
//  Tars
//
//  Created by 이윤영 on 2022/11/15.
//

import UIKit

class CustomArrowView: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func draw(_ rect: CGRect) {
        let triangle = UIBezierPath()
        triangle.lineJoinStyle = .round
        triangle.lineWidth = 5.0
        triangle.move(to: CGPoint(x: 12, y: 12))
        triangle.addLine(to: CGPoint(x: frame.width - 12, y: frame.height / 2))
        triangle.addLine(to: CGPoint(x: 12, y: frame.height-12))
        
        UIColor.customYellow.set()
        triangle.close()
        triangle.stroke()
        triangle.fill()
    }
}
