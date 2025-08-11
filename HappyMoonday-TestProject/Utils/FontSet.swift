//
//  FontSet.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/10/25.
//

import UIKit

enum FontSet {
    case regular
    case medium
    case semiBold
    case bold

    func font(_ size: CGFloat) -> UIFont? {
        switch self {
        case .regular:
            return UIFont(name: "Pretendard-Regular", size: size)
        case .medium:
            return UIFont(name: "Pretendard-Medium", size: size)
        case .semiBold:
            return UIFont(name: "Pretendard-Semibold", size: size)
        case .bold:
            return UIFont(name: "Pretendard-Bold", size: size)
        }
    }
}
