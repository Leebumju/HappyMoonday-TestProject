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
    
    private lazy var bookBackgroundView: GradientView = GradientView()
    
    private lazy var bookImageView: UIImageView = UIImageView().then {
        $0.setImageWithSpinner(
            urlString: viewModel.bookInfo.image,
            placeholder: UIImage(systemName: "photo")
        )
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var bookTitleStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = moderateScale(number: 4)
    }
    
    private lazy var bookTitleLabel: UILabel = UILabel().then {
        $0.attributedText = FontManager.title2B.setFont(viewModel.bookInfo.title,
                                                        alignment: .left)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    private lazy var authorLabel: UILabel = UILabel().then {
        $0.attributedText = FontManager.title3M.setFont("\(viewModel.bookInfo.author) 저",
                                                        alignment: .left)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.highLightText(targetString: "저", color: .systemGray, font: FontManager.title3M.font)
    }
    
    private lazy var publisherLabel: UILabel = UILabel().then {
        $0.attributedText = FontManager.title4M.setFont("\(viewModel.bookInfo.publisher) , \(viewModel.bookInfo.pubdate)",
                                                        alignment: .left)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.highLightText(targetString: viewModel.bookInfo.pubdate, color: .systemGray, font: FontManager.title4M.font)
    }
    
    private lazy var firstDividerView: UIView = UIView().then {
        $0.backgroundColor = .systemGray4
    }
    
    private lazy var bookPriceStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = moderateScale(number: 4)
    }
    
    private lazy var linkLabel: UILabel = UILabel().then {
        $0.text = viewModel.bookInfo.link
        $0.textColor = .systemGray
        $0.numberOfLines = 0
    }
    
    private lazy var discountLabel: UILabel = UILabel().then {
        $0.text = viewModel.bookInfo.discount
        $0.textColor = .systemGray
        $0.numberOfLines = 0
    }
    
    private lazy var secondDividerView: UIView = UIView().then {
        $0.backgroundColor = .systemGray4
    }
    
    private lazy var bookDescriptionStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = moderateScale(number: 4)
    }
    
    private lazy var descriptionLabel: UILabel = UILabel().then {
        $0.text = viewModel.bookInfo.description
        $0.textColor = .systemGray
        $0.numberOfLines = 0
    }
    
    private lazy var bookStateStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = moderateScale(number: 20)
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
        containerView.addSubviews([bookBackgroundView,
                                   bookStateStackView,
                                   bookTitleStackView,
                                   firstDividerView,
                                   bookPriceStackView,
                                   secondDividerView,
                                   bookDescriptionStackView])
        bookBackgroundView.addSubview(bookImageView)
        bookStateStackView.addArrangedSubviews([readingBookImageView,
                                                wantToReadBookImageView,
                                                readDoneBookImageView])
        bookTitleStackView.addArrangedSubviews([bookTitleLabel,
                                                authorLabel,
                                                publisherLabel])
        bookPriceStackView.addArrangedSubviews([linkLabel,
                                                discountLabel])
        bookDescriptionStackView.addArrangedSubviews([descriptionLabel])
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(getSafeAreaBottom())
        }
        
        containerView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        bookBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(moderateScale(number: 20))
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(moderateScale(number: 500))
        }
        
        bookImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(moderateScale(number: 400))
        }
        
        bookStateStackView.snp.makeConstraints {
            $0.bottom.equalTo(bookImageView)
            $0.trailing.equalToSuperview().offset(moderateScale(number: -20))
        }
        
        [wantToReadBookImageView,
         readDoneBookImageView].forEach {
            $0.snp.makeConstraints {
                $0.size.equalTo(moderateScale(number: 26))
            }
        }
        
        bookTitleStackView.snp.makeConstraints {
            $0.top.equalTo(bookBackgroundView.snp.bottom).offset(moderateScale(number: 20))
            $0.leading.trailing.equalToSuperview().inset(moderateScale(number: 20))
        }
        
        firstDividerView.snp.makeConstraints {
            $0.top.equalTo(bookTitleStackView.snp.bottom).offset(moderateScale(number: 6))
            $0.height.equalTo(moderateScale(number: 12))
            $0.leading.trailing.equalToSuperview()
        }
        
        bookPriceStackView.snp.makeConstraints {
            $0.top.equalTo(firstDividerView.snp.bottom).offset(moderateScale(number: 16))
            $0.leading.trailing.equalToSuperview().inset(moderateScale(number: 20))
        }
        
        secondDividerView.snp.makeConstraints {
            $0.top.equalTo(bookPriceStackView.snp.bottom).offset(moderateScale(number: 6))
            $0.height.equalTo(moderateScale(number: 12))
            $0.leading.trailing.equalToSuperview()
        }
        
        bookDescriptionStackView.snp.makeConstraints {
            $0.top.equalTo(secondDividerView.snp.bottom).offset(moderateScale(number: 16))
            $0.leading.trailing.equalToSuperview().inset(moderateScale(number: 20))
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

import UIKit

class GradientView: UIView {
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }

    private func setupGradient() {
        gradientLayer.colors = [
            UIColor(red: 130/255, green: 38/255, blue: 38/255, alpha: 1.0).cgColor,  // 밑에 진한 붉은 갈색
            UIColor(red: 193/255, green: 74/255, blue: 62/255, alpha: 0.3).cgColor   // 위에 연한 붉은 갈색 (투명)
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1) // 밑에서 시작 (중앙 하단)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)   // 위로 끝 (중앙 상단)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
