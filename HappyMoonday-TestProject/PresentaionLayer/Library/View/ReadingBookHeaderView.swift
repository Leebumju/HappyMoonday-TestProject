//
//  ReadingBookHeaderView.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/10/25.
//

import UIKit
import Then
import SnapKit

final class ReadingBookHeaderView: UICollectionReusableView {
    private lazy var containerView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.attributedText = FontManager.body1SB.setFont("읽고 있는 책",
                                                        alignment: .left)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addViews() {
        addSubview(containerView)
        containerView.addSubviews([titleLabel])
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(moderateScale(number: 20))
            $0.top.bottom.equalToSuperview().inset(moderateScale(number: 12))
        }
    }
}
