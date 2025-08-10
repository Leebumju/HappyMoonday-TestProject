//
//  SelectableView.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/10/25.
//

import UIKit
import Then
import SnapKit

enum SelectableType {
    case bookCategory
    
    var placeholderText: String {
        switch self {
        case .bookCategory:
            return "추가할 카테고리를 선택해 주세요."
        }
    }
}

final class SelectableView: TouchableView {
    private lazy var placeholder = UILabel().then {
        $0.attributedText = FontManager.body2M.setFont(selectableType.placeholderText,
                                                       alignment: .left)
        $0.textColor = .systemGray3
    }
    
    private lazy var downArrowImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "chevron.down")?.withTintColor(.systemGray,
                                                                      renderingMode: .alwaysOriginal)
    }
    
    private lazy var selectedView = UIStackView().then {
        $0.alignment = .center
        $0.isHidden = true
    }
    
    private lazy var selectedImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var selectedItemText = UILabel().then {
        $0.attributedText = FontManager.body2M.setFont(alignment: .left)
        $0.textColor = .black
    }
    
    private let selectableType: SelectableType
    
    init(selectableType: SelectableType) {
        self.selectableType = selectableType
        
        super.init(frame: .zero)
        
        backgroundColor = .systemGray6
        layer.cornerRadius = moderateScale(number: 12)
        layer.masksToBounds = true
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubviews([placeholder, downArrowImageView, selectedView])
    }
    
    private func makeConstraints() {
        placeholder.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(moderateScale(number: 16))
            $0.trailing.equalTo(downArrowImageView.snp.leading).offset(-moderateScale(number: 8))
        }
        
        downArrowImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(moderateScale(number: 16))
            $0.size.equalTo(moderateScale(number: 20))
        }
        
        selectedView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(moderateScale(number: 16))
            $0.trailing.equalTo(downArrowImageView.snp.leading).offset(-moderateScale(number: 8))
        }
    }
    
    func didSelectItem(with selectedItemText: String) {
        placeholder.isHidden = true
        selectedView.isHidden = false
        self.selectedItemText.text = selectedItemText
    }
    
    func getSelectedValue() -> String? {
        return selectedItemText.text
    }
}
