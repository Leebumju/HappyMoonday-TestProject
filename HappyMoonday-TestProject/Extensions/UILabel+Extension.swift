//
//  UILabel+Extension.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/11/25.
//

import UIKit

extension UILabel {
    func highLightText(targetString: String?, color: UIColor?, font: UIFont?) {
        guard let targetString = targetString else { return }
        
        var attributedString: NSMutableAttributedString
        let fullText: String = text ?? ""
        
        if let attributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        } else {
            attributedString = NSMutableAttributedString(string: fullText)
        }
        
        let range = (fullText.lowercased() as NSString).range(of: targetString.lowercased())
        
        if let color = color {
            attributedString.addAttribute(.foregroundColor, value: color, range: range)
        }
        
        if let font = font {
            attributedString.addAttribute(.font, value: font, range: range)
        }
        
        attributedText = attributedString
    }
}
