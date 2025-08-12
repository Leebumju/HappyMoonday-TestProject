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
    private var deleteMode: Bool = false
    
    private lazy var containerView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.attributedText = FontManager.body1SB.setFont("읽고 있는 책",
                                                        alignment: .left)
    }
    
    private(set) lazy var deleteButton: TouchableLabel = TouchableLabel().then {
        $0.attributedText = FontManager.body1B.setFont("편집", alignment: .right)
        $0.textColor = .systemGray
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
                                   deleteButton])
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(moderateScale(number: 20))
            $0.top.bottom.equalToSuperview().inset(moderateScale(number: 12))
        }
        
        deleteButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(moderateScale(number: -20))
        }
    }
    
    func updateDeleteMode() {
        deleteMode.toggle()
        deleteButton.text = deleteMode ? "완료" : "삭제"
    }
}
