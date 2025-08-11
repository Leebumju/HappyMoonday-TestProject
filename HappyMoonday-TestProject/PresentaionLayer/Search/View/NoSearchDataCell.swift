//
//  NoDataCell.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import UIKit
import SnapKit
import Then

final class NoSearchDataCell: UICollectionViewCell {
    private lazy var noDataLabel: UILabel = UILabel().then {
        $0.text = "검색 결과가 없어요!"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(noDataLabel)
        
        noDataLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
