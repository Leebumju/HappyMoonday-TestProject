//
//  BookDetailViewController.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import UIKit
import SnapKit
import Then
import Combine

final class BookDetailViewController: BaseNavigationViewController, CommonCoordinated {
    private var cancelBag = Set<AnyCancellable>()
    var coordinator: AnyCommonCoordinator?
    
    private lazy var scrollView: UIScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var containerView: UIView = UIView()
    
    private lazy var bookImageView: UIImageView = UIImageView().then {
        $0.setImageWithSpinner(
            urlString: viewModel.bookInfo.image,
            placeholder: UIImage(systemName: "photo")
        )
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var bookDetailStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = moderateScale(number: 4)
    }
    
    private lazy var bookTitleLabel: UILabel = UILabel().then {
        $0.text = viewModel.bookInfo.title
        $0.textColor = .systemGray
        $0.numberOfLines = 0
    }
    
    private lazy var linkLabel: UILabel = UILabel().then {
        $0.text = viewModel.bookInfo.link
        $0.textColor = .systemGray
        $0.numberOfLines = 0
    }
    
    private lazy var authorLabel: UILabel = UILabel().then {
        $0.text = viewModel.bookInfo.author
        $0.textColor = .systemGray
        $0.numberOfLines = 0
    }
    
    private lazy var discountLabel: UILabel = UILabel().then {
        $0.text = viewModel.bookInfo.discount
        $0.textColor = .systemGray
        $0.numberOfLines = 0
    }
    
    private lazy var publisherLabel: UILabel = UILabel().then {
        $0.text = viewModel.bookInfo.publisher
        $0.textColor = .systemGray
        $0.numberOfLines = 0
    }
    
    private lazy var pubdateLabel: UILabel = UILabel().then {
        $0.text = viewModel.bookInfo.pubdate
        $0.textColor = .systemGray
        $0.numberOfLines = 0
    }
    
    private lazy var isbnLabel: UILabel = UILabel().then {
        $0.text = viewModel.bookInfo.isbn
        $0.textColor = .systemGray
        $0.numberOfLines = 0
    }
    
    private lazy var descriptionLabel: UILabel = UILabel().then {
        $0.text = viewModel.bookInfo.description
        $0.textColor = .systemGray
        $0.numberOfLines = 0
    }
    
    private lazy var bookStateStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = moderateScale(number: 10)
    }
    
    private lazy var readingBookImageView: TouchableImageView = TouchableImageView(frame: .zero).then {
        $0.image = UIImage(systemName: "book.fill")?.withTintColor(.systemGray6,
                                                                   renderingMode: .alwaysOriginal)
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var wantToReadBookImageView: TouchableImageView = TouchableImageView(frame: .zero).then {
        $0.image = UIImage(systemName: "star.fill")?.withTintColor(.systemGray6,
                                                                   renderingMode: .alwaysOriginal)
        $0.contentMode = .scaleAspectFit
    }

    private lazy var readDoneBookImageView: TouchableImageView = TouchableImageView(frame: .zero).then {
        $0.image = UIImage(systemName: "checkmark.seal.fill")?.withTintColor(.systemGray6,
                                                                   renderingMode: .alwaysOriginal)
        $0.contentMode = .scaleAspectFit
    }
    
    private let viewModel: BookDetailViewModel
    
    init(viewModel: BookDetailViewModel) {
        self.viewModel = viewModel
        super.init()
        self.updateTitleLabel(with: viewModel.bookInfo.title)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    override func addViews() {
        super.addViews()
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews([bookImageView,
                                   bookStateStackView,
                                   bookDetailStackView])
        bookStateStackView.addArrangedSubviews([readingBookImageView,
                                                wantToReadBookImageView,
                                                readDoneBookImageView])
        bookDetailStackView.addArrangedSubviews([bookTitleLabel,
                                                 linkLabel,
                                                 authorLabel,
                                                 isbnLabel,
                                                 pubdateLabel,
                                                 discountLabel,
                                                 publisherLabel,
                                                 descriptionLabel])
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(moderateScale(number: 20))
            $0.bottom.equalToSuperview().inset(getSafeAreaBottom())
        }
        
        containerView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        bookImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(moderateScale(number: 20))
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(moderateScale(number: 200))
        }
        
        bookStateStackView.snp.makeConstraints {
            $0.bottom.equalTo(bookImageView)
            $0.trailing.equalToSuperview()
        }
        
        [wantToReadBookImageView,
         readDoneBookImageView].forEach {
            $0.snp.makeConstraints {
                $0.size.equalTo(moderateScale(number: 24))
            }
        }
        
        bookDetailStackView.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(moderateScale(number: 20))
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setupIfNeeded() {
        super.setupIfNeeded()
        
        readingBookImageView.didTapped { [weak self] in
            CommonUtil.showAlertView(title: "카테고리 추가",
                                     description: "읽고 있는 책 카테고리에 추가할게요!",
                                     submitCompletion: { self?.changeBookCategory(with: .reading) })
        }
        
        wantToReadBookImageView.didTapped { [weak self] in
            CommonUtil.showAlertView(title: "카테고리 추가",
                                     description: "읽고 싶은 책 카테고리에 추가할게요!",
                                     submitCompletion: { self?.changeBookCategory(with: .wantToRead) })
        }
        
        readDoneBookImageView.didTapped { [weak self] in
            CommonUtil.showAlertView(title: "카테고리 추가",
                                     description: "읽었던 책 카테고리에 추가할게요!",
                                     submitCompletion: { self?.changeBookCategory(with: .readDone) })
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
    
    private func changeBookCategory(with category: BookCategory) {
        do {
            CommonUtil.showLoadingView()
            try viewModel.changeBookCategory(viewModel.bookInfo,
                                             to: category)
            CommonUtil.hideLoadingView()
            NotificationCenter.default.post(name: .bookCategoryIsUpdated,
                                            object: nil,
                                            userInfo: ["bookCategory": category])
            self.showToastMessageView(title: "나의 책 보관함에 저장되었어요!")
        } catch {}
    }
}
