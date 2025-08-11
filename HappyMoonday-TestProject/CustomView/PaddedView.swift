//
//  PaddedView.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import UIKit

final class PaddedView: TouchableView {
    private var vertical: CGFloat = 0.0
    private var horizontal: CGFloat = 0.0
    
    private(set) lazy var titleLabel = UILabel()
    
    convenience init(vertical: CGFloat, horizontal: CGFloat) {
        self.init()
        self.vertical = vertical
        self.horizontal = horizontal
        
        addViews()
        makeConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(titleLabel)
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(moderateScale(number: vertical))
            $0.leading.trailing.equalToSuperview().inset(moderateScale(number: horizontal))
        }
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += moderateScale(number: vertical) * 2
        contentSize.width += moderateScale(number: horizontal) * 2
        
        return contentSize
    }
}
