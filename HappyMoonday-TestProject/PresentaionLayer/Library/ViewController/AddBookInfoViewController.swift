//
//  AddBookInfoViewController.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/10/25.
//
import UIKit
import SnapKit
import Then
import Combine

final class AddBookInfoViewController: BaseNavigationViewController {
    var coordinator: AnyLibraryCoordinator?
    
    private lazy var bookTitleLabel: UILabel = UILabel().then {
        $0.attributedText = FontManager.body4M.setFont("책 제목",
                                                       alignment: .left)
        $0.textColor = .black
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    private lazy var bookTitleTextField: UITextField = UITextField().then {
        $0.addLeftPadding(moderateScale(number: 12 + 20 + 8))
        $0.addRightPadding(moderateScale(number: 8 + 16 + 12))
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = moderateScale(number: 12)
        $0.textColor = .black
        $0.delegate = self
        $0.setCustomPlaceholder(placeholder: "책을 검색해 주세요",
                                color: .systemGray3,
                                font: FontManager.body2M.font)
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private let viewModel: AddBookInfoViewModel
    
    init(viewModel: AddBookInfoViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTitleLabel(with: "책 추가")
    }
    
    override func addViews() {
        super.addViews()
    }
    
    override func makeConstraints() {
        super.makeConstraints()
    }
    
    override func setupIfNeeded() {
        super.setupIfNeeded()
    }
    
    @objc
    private func textFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        
    }
}
