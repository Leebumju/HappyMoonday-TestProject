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
    private var deleteMode: Bool = false
    
    private lazy var containerView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.attributedText = FontManager.body1SB.setFont(alignment: .left)
    }
    
    private(set) lazy var deleteButton: TouchableLabel = TouchableLabel().then {
        $0.attributedText = FontManager.body2M.setFont("편집", alignment: .right)
        $0.textColor = .systemGray
    }
    
    private lazy var dividerView: UIView = UIView().then {
        $0.backgroundColor = .systemGray5
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
                                   deleteButton,
                                   dividerView])
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(moderateScale(number: 20))
            $0.top.equalToSuperview().offset(moderateScale(number: 20))
            $0.bottom.equalToSuperview().offset(moderateScale(number: -12))
        }
        
        deleteButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(moderateScale(number: -20))
        }
        
        dividerView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(moderateScale(number: 8))
        }
    }
    
    func updateView(with titleText: String) {
        titleLabel.text = titleText
    }
    
    func updateDeleteMode() {
        deleteMode.toggle()
        deleteButton.text = deleteMode ? "완료" : "삭제"
    }
}
