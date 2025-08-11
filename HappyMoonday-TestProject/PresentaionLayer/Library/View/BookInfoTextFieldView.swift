//
//  BookInfoTextFieldView.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/10/25.
//

import UIKit
import Then
import SnapKit

protocol BookInfoTextFieldViewDelegate: AnyObject {
    func textFieldDidChange(_ text: String)
}

final class BookInfoTextFieldView: UIStackView {
    weak var delegate: BookInfoTextFieldViewDelegate?
    
    private lazy var titleLabel = UILabel().then {
        $0.attributedText = FontManager.body4M.setFont(textFieldType.titleText,
                                                       alignment: .left)
        $0.textColor = .black
    }
    
    private lazy var textField: UITextField = UITextField().then {
        $0.layer.cornerRadius = moderateScale(number: 12)
        $0.backgroundColor = .systemGray6
        $0.addLeftPadding(moderateScale(number: 16))
        $0.addRightPadding(moderateScale(number: 8 + 24 + 16))
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        $0.font = FontManager.body2M.font
        $0.textColor = .black
        $0.setCustomPlaceholder(placeholder: textFieldType.placeholder,
                                color: .systemGray3,
                                font: FontManager.body2M.font)
    }
    
    private let textFieldType: TextFieldType
    
    init(textFieldType: TextFieldType) {
        self.textFieldType = textFieldType
        super.init(frame: .zero)
        
        axis = .vertical
        alignment = .fill
        distribution = .equalSpacing
        spacing = moderateScale(number: 4)
        
        addViews()
        makeConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addArrangedSubviews([titleLabel,
                             textField])
    }
    
    private func makeConstraints() {
        textField.snp.makeConstraints {
            $0.height.equalTo(moderateScale(number: 56))
        }
    }
    
    func getUserData() -> String {
        return textField.text ?? ""
    }
    
    @objc
    private func textFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        delegate?.textFieldDidChange(text)
    }
}

extension BookInfoTextFieldView {
    enum TextFieldType {
        case bookTitle
        case author
        
        var placeholder: String {
            switch self {
            case .bookTitle:    return "책 제목을 입력해 주세요"
            case .author:       return "저자를 입력해 주세요"
            }
        }
        
        var titleText: String {
            switch self {
            case .bookTitle: return "책 제목"
            case .author: return "책 저자"
            }
        }
    }
}
