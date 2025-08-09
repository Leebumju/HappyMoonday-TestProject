//
//  FavoriteBookHeaderView.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/10/25.
//

import UIKit
import Then
import SnapKit

final class FavoriteBookHeaderView: UICollectionReusableView {
    private lazy var containerView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var titleLabel: UILabel = UILabel()
    
    private lazy var dividerView: UIView = UIView().then {
        $0.backgroundColor = .systemGray6
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
        containerView.addSubviews([titleLabel,
                                   dividerView])
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(moderateScale(number: 20))
            $0.top.equalToSuperview().offset(moderateScale(number: 12))
            $0.bottom.equalToSuperview().offset(moderateScale(number: -20))
        }
        
        dividerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(moderateScale(number: 8))
        }
    }
    
    func updateView(with titleText: String) {
        titleLabel.text = titleText
    }
}
