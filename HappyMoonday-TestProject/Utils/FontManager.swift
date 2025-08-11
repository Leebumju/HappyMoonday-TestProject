//
//  FontManager.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/10/25.
//

import UIKit

enum FontManager {
    case display0B
    case display1B
    case display1M
    case display1R
    case display2B
    case display2R
    case display3B
    case display3M
    case display3R
    case display4B
    
    case headline1B
    case headline1M
    case headline1R
    case headline2B
    case headline2SB
    case headline2M
    case headline2R
    case headline3B
    case headline3SB
    case headline3M
    
    case title1B
    case title1SB
    case title1M
    case title2SB
    case title2B
    case title2M
    case title3B
    case title3SB
    case title3M
    case title4M
    case title4SB
    
    case body1B
    case body1SB
    case body1M
    case body1R
    case body2SB
    case body2B
    case body2M
    case body2M_20
    case body2R
    case body3B
    case body3SB
    case body3M
    case body3R
    case body4R
    case body4SB
    case body4M
    case body4M_16
    
    case lable1B
    case lable1SB
    case lable1M
    case lable1R
    case lable2R
    case lable2M
    case lable3M
    case lable3R
    
    var font: UIFont? {
        switch self {
        case .display0B:
            return FontSet.bold.font(moderateScale(number: 60))
        case .display1B:
            return FontSet.bold.font(moderateScale(number: 56))
        case .display1M:
            return FontSet.medium.font(moderateScale(number: 56))
        case .display1R:
            return FontSet.regular.font(moderateScale(number: 56))
        case .display2B:
            return FontSet.bold.font(moderateScale(number: 44))
        case .display2R:
            return FontSet.regular.font(moderateScale(number: 44))
        case .display3M:
            return FontSet.medium.font(moderateScale(number: 36))
        case .display3R:
            return FontSet.regular.font(moderateScale(number: 36))
        case .display3B:
            return FontSet.bold.font(moderateScale(number: 36))
        case .display4B:
            return FontSet.bold.font(moderateScale(number: 34))
            
        case .headline1R:
            return FontSet.regular.font(moderateScale(number: 32))
        case .headline1B:
            return FontSet.bold.font(moderateScale(number: 32))
        case .headline1M:
            return FontSet.medium.font(moderateScale(number: 32))
        case .headline2B:
            return FontSet.bold.font(moderateScale(number: 28))
        case .headline2SB:
            return FontSet.semiBold.font(moderateScale(number: 28))
        case .headline2M:
            return FontSet.medium.font(moderateScale(number: 28))
        case .headline2R:
            return FontSet.regular.font(moderateScale(number: 28))
        case .headline3B:
            return FontSet.bold.font(moderateScale(number: 24))
        case .headline3SB:
            return FontSet.semiBold.font(moderateScale(number: 24))
        case .headline3M:
            return FontSet.medium.font(moderateScale(number: 24))
            
        case .title1B:
            return FontSet.bold.font(moderateScale(number: 22))
        case .title1SB:
            return FontSet.semiBold.font(moderateScale(number: 22))
        case .title1M:
            return FontSet.medium.font(moderateScale(number: 22))
        case .title2SB:
            return FontSet.semiBold.font(moderateScale(number: 20))
        case .title2B:
            return FontSet.bold.font(moderateScale(number: 20))
        case .title2M:
            return FontSet.medium.font(moderateScale(number: 20))
        case .title3B:
            return FontSet.bold.font(moderateScale(number: 18))
        case .title3SB:
            return FontSet.semiBold.font(moderateScale(number: 18))
        case .title3M:
            return FontSet.medium.font(moderateScale(number: 18))
        case .title4M:
            return FontSet.medium.font(moderateScale(number: 17))
        case .title4SB:
            return FontSet.semiBold.font(moderateScale(number: 17))
            
        case .body1B:
            return FontSet.bold.font(moderateScale(number: 16))
        case .body1SB:
            return FontSet.semiBold.font(moderateScale(number: 16))
        case .body1M:
            return FontSet.medium.font(moderateScale(number: 16))
        case .body1R:
            return FontSet.regular.font(moderateScale(number: 16))
        case .body2SB:
            return FontSet.semiBold.font(moderateScale(number: 15))
        case .body2B:
            return FontSet.bold.font(moderateScale(number: 15))
        case .body2M:
            return FontSet.medium.font(moderateScale(number: 15))
        case .body2M_20:
            return FontSet.medium.font(moderateScale(number: 15))
        case .body2R:
            return FontSet.regular.font(moderateScale(number: 15))
        case .body3B:
            return FontSet.bold.font(moderateScale(number: 14))
        case .body3SB:
            return FontSet.semiBold.font(moderateScale(number: 14))
        case .body3M:
            return FontSet.medium.font(moderateScale(number: 14))
        case .body3R:
            return FontSet.regular.font(moderateScale(number: 14))
        case .body4R:
            return FontSet.regular.font(moderateScale(number: 13))
        case .body4SB:
            return FontSet.semiBold.font(moderateScale(number: 13))
        case .body4M:
            return FontSet.medium.font(moderateScale(number: 13))
        case .body4M_16:
            return FontSet.medium.font(moderateScale(number: 13))
            
        case .lable1B:
            return FontSet.bold.font(moderateScale(number: 12))
        case .lable1SB:
            return FontSet.semiBold.font(moderateScale(number: 12))
        case .lable1M:
            return FontSet.medium.font(moderateScale(number: 12))
        case .lable1R:
            return FontSet.regular.font(moderateScale(number: 12))
        case .lable2R:
            return FontSet.regular.font(moderateScale(number: 11))
        case .lable2M:
            return FontSet.medium.font(moderateScale(number: 11))
        case .lable3R:
            return FontSet.regular.font(moderateScale(number: 10))
        case .lable3M:
            return FontSet.medium.font(moderateScale(number: 10))
        }
    }
    
    private var lineHeight: CGFloat {
        switch self {
        case .display1M, .display1R, .display0B, .display1B:
            return 68
        case .display2B, .display2R:
            return 56
        case .display3M, .display3R, .display3B:
            return 46
        case .headline1B, .headline1M, .display4B, .headline1R:
            return 42
        case .headline2B, .headline2M, .headline2R, .headline2SB:
            return 38
        case .headline3B, .headline3SB, .headline3M:
            return 34
        case .title1B, .title1SB, .title1M:
            return 32
        case .title2SB, .title2B, .title2M:
            return 30
        case .title3B, .title3M, .title3SB:
            return 26
        case .title4M, .title4SB:
            return 28
        case .body1B, .body1SB, .body1M, .body1R:
            return 24
        case .body2SB, .body2B, .body2M, .body2R:
            return 22
        case .body3B, .body3SB, .body3M, .body3R, .body2M_20:
            return 20
        case .body4R, .body4M, .body4SB:
            return 18
        case .lable1B, .lable1SB, .body4M_16:
            return 16
        case .lable1M, .lable1R, .lable2R, .lable2M:
            return 14
        case .lable3R, .lable3M:
            return 12
        }
    }
    
    func setFont(_ text: String? = " ", alignment: NSTextAlignment?) -> NSMutableAttributedString? {
        guard let text = text else { return nil }
        guard let font = self.font else { return nil }
        
        let fontSize: CGFloat = font.pointSize
        let lineHeight: CGFloat = max(lineHeight, fontSize + 0.2 * fontSize)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.alignment = alignment ?? .left
        
        var offsetDivisor: CGFloat = 4.0
        
        if #available(iOS 16.4, *) {
            offsetDivisor = 2.0
        }
        
        let baselineOffset: CGFloat = (lineHeight - fontSize) / offsetDivisor
        
        let attributes: [NSAttributedString.Key: Any] = [.paragraphStyle: paragraphStyle,
                                                         .font: font,
                                                         .baselineOffset: baselineOffset,
                                                         .kern: -0.2]
        
        return NSMutableAttributedString(string: text, attributes: attributes)
    }
}
