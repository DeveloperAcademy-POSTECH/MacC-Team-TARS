//
//  Label+Extension.swift
//  Tars
//
//  Created by Ayden on 2022/10/25.
//

import UIKit

extension UILabel {
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
}

extension UILabel {
    
    /// font size의 하드코딩 입력 없이, textStyle에 bold 효과를 주기 위한 메서드
    func setBoldFont(forTextStyle textStyle: UIFont.TextStyle) {
        if let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle).withSymbolicTraits(.traitBold) {
            self.font = UIFont(descriptor: descriptor, size: 0)
        } else {
            self.font = UIFont.preferredFont(forTextStyle: textStyle)
        }
    }
}
