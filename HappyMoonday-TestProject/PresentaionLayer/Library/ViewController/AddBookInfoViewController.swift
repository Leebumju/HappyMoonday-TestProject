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
    private(set) var cancelBag = Set<AnyCancellable>()
    var coordinator: AnyLibraryCoordinator?
    
    private var bottomConstraint: Constraint?
    
    private lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var containerView: UIView = UIView()
    
    private lazy var containerStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = moderateScale(number: 12)
    }
    
    private lazy var categoryTitleLabel: UILabel = UILabel().then {
        $0.attributedText = FontManager.body4M.setFont("카테고리 선택",
                                                       alignment: .left)
        $0.textColor = .black
    }
    
    private lazy var categorySelectableView: SelectableView = SelectableView(selectableType: .bookCategory)
    
    private lazy var bookTitleTextFieldView: BookInfoTextFieldView = BookInfoTextFieldView(textFieldType: .bookTitle).then {
        $0.delegate = self
    }
    
    private lazy var authorTextFieldView: BookInfoTextFieldView = BookInfoTextFieldView(textFieldType: .author).then {
        $0.delegate = self
    }
    
    private lazy var descriptionTitleLabel: UILabel = UILabel().then {
        $0.attributedText = FontManager.body4M.setFont("책 설명(선택 사항)",
                                                       alignment: .left)
        $0.textColor = .black
    }
    
    private lazy var descriptionTextView: UITextView = UITextView().then {
        $0.isScrollEnabled = true
        $0.textColor = .black
        $0.font = FontManager.body2M.font
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = moderateScale(number: 12)
    }
    
    private lazy var saveButton: TouchableLabel = TouchableLabel().then {
        $0.text = "저장"
        $0.textColor = .white
        $0.layer.cornerRadius = moderateScale(number: 12)
        $0.textAlignment = .center
        $0.layer.masksToBounds = true
        $0.setClickable(false)
    }
    
    private let viewModel: AddBookInfoViewModel
    
    init(viewModel: AddBookInfoViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTitleLabel(with: "책 추가")
        bind()
    }
    
    override func addViews() {
        super.addViews()
        
        view.addSubviews([scrollView, saveButton])
        scrollView.addSubview(containerView)
        containerView.addSubviews([containerStackView])
        containerStackView.addArrangedSubviews([categoryTitleLabel,
                                                categorySelectableView,
                                                bookTitleTextFieldView,
                                                authorTextFieldView,
                                                descriptionTitleLabel,
                                                descriptionTextView])
        containerStackView.setCustomSpacing(moderateScale(number: 4),
                                            after: categoryTitleLabel)
        containerStackView.setCustomSpacing(moderateScale(number: 4),
                                            after: descriptionTitleLabel)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        scrollView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(saveButton.snp.top).offset(moderateScale(number: -24))
        }
        
        containerView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(moderateScale(number: 10))
            $0.leading.trailing.equalToSuperview().inset(moderateScale(number: 20))
            $0.bottom.equalToSuperview()
        }
        
        categorySelectableView.snp.makeConstraints {
            $0.height.equalTo(moderateScale(number: 56))
        }
        
        descriptionTextView.snp.makeConstraints {
            $0.height.equalTo(moderateScale(number: 300))
        }
        
        saveButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(moderateScale(number: 20))
            $0.height.equalTo(moderateScale(number: 52))
            $0.bottom.equalToSuperview().inset(getDefaultSafeAreaBottom())
        }
    }
    
    override func setupIfNeeded() {
        super.setupIfNeeded()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        scrollView.addGestureRecognizer(tapGestureRecognizer)
        
        categorySelectableView.didTapped { [weak self] in
            self?.coordinator?.moveToAnotherFlow(TabBarFlow.common(.singleTextBottomSheet),
                                                 userData: ["selectableList": [SelectedCategory.reading.rawValue,
                                                                               SelectedCategory.wantToRead.rawValue,
                                                                               SelectedCategory.readDone.rawValue],
                                                            "delegate": self])
        }
        
        saveButton.didTapped { [weak self] in
            self?.saveBookInfo()
        }
    }
    
    private func bind() {
        viewModel.getErrorSubject()
            .mainSink { [weak self] error in
                CommonUtil.showAlertView(title: "error",
                                         description: error.localizedDescription,
                                         submitText: "확인",
                                         submitCompletion: nil)
            }.store(in: &cancelBag)
    }
    
    func saveBookInfo() {
        Task {
            do {
                CommonUtil.showLoadingView()
                try viewModel.saveBookInfo(title: bookTitleTextFieldView.getUserData(),
                                             author: authorTextFieldView.getUserData(),
                                             description: descriptionTextView.text)
                CommonUtil.hideLoadingView()
                guard let selectedCategory = viewModel.selectedCategory else { return }
                NotificationCenter.default.post(name: .bookCategoryIsUpdated,
                                                object: nil,
                                                userInfo: ["bookCategory": selectedCategory.bookCategory])
                self.showToastMessageView(title: "책 보관함에 저장이 완료되었어요!") { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                }
            } catch {}
        }
    }
    
    @objc
    private func handleTapGesture() {
        view.endEditing(true)
    }
    
    @objc
    private func textFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        
    }
}

extension AddBookInfoViewController: BookInfoTextFieldViewDelegate {
    func textFieldDidChange(_ text: String) {
        if !bookTitleTextFieldView.getUserData().isEmpty && !authorTextFieldView.getUserData().isEmpty && !categorySelectableView.getSelectedValue().isEmpty {
            saveButton.setClickable(true)
        } else {
            saveButton.setClickable(false)
        }
    }
}

extension AddBookInfoViewController: SingleTextBottomSheetViewControllerDelegate {
    func didSelectText(text: String) {
        categorySelectableView.didSelectItem(with: text)
        viewModel.updateCategory(with: text)
    }
}
