//
//  NoDataCell.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/10/25.
//

import UIKit
import SnapKit
import Then

final class NoDataCell: UICollectionViewCell {
    
    private lazy var containerStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = moderateScale(number: 10)
        $0.alignment = .center
    }
    
    private lazy var noDataLabel: UILabel = UILabel().then {
        $0.text = "해당하는 책이 없어요.\n지금 추가해보세요!"
        $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
    
    private lazy var confirmButton = TouchableLabel().then {
        $0.text = "확인"
        $0.textColor = .white
        $0.layer.cornerRadius = moderateScale(number: 12)
        $0.backgroundColor = .blue
        $0.textAlignment = .center
        $0.layer.masksToBounds = true
        $0.setContentHuggingPriority(.defaultLow, for: .vertical)
        $0.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(containerStackView)
        containerStackView.addArrangedSubviews([noDataLabel,
                                                confirmButton])
        
        containerStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints {
            $0.height.equalTo(moderateScale(number: 48))
            $0.width.equalTo(moderateScale(number: 60))
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
