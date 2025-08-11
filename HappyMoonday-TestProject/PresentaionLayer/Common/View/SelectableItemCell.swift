//
//  SelectableItemCell.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/10/25.
//

import UIKit
import Then
import SnapKit

final class SelectableItemCell: UICollectionViewCell {
    private(set) lazy var containerView: TouchableView = TouchableView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var titleStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
    }
    
    private lazy var titleText: UILabel = UILabel().then {
        $0.attributedText = FontManager.body2M.setFont(alignment: .left)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(containerView)
        containerView.addSubviews([titleStackView])
        titleStackView.addArrangedSubviews([titleText])
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(moderateScale(number: 20))
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-moderateScale(number: 16))
        }
    }
    
    func updateView(with text: String) {
        self.titleText.text = text
    }
}
