//
//  SearchMainViewController.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import UIKit
import SnapKit
import Then
import Combine
class SearchBooksMainViewController: BaseViewController {
    private var cancelBag = Set<AnyCancellable>()
    var coordinator: AnySearchCoordinator?
    
    private var storedKeyword: String = ""
    
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.attributedText = FontManager.title2SB.setFont("도서 검색",
                                                         alignment: .center)
    }
    
    private lazy var searchTextField: UITextField = UITextField().then {
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
    
    private lazy var searchKeywordView: AlignedContainerView = AlignedContainerView()
    
    private lazy var searchImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")?.withTintColor(.systemGray3, renderingMode: .alwaysOriginal)
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var searchedBookListView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.showsVerticalScrollIndicator = false
        $0.dataSource = self
        $0.delegate = self
        $0.registerCell(NoSearchDataCell.self)
        $0.registerCell(BookCell.self)
    }

    private let viewModel: SearchBooksMainViewModel
    
    init(viewModel: SearchBooksMainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        view.addSubviews([titleLabel,
                          searchTextField,
                          searchKeywordView,
                          searchedBookListView])
        searchTextField.addSubview(searchImageView)
    }
    
    override func makeConstraints() {
        let tabBarHeight: CGFloat = tabBarController?.tabBar.bounds.height ?? moderateScale(number: 48) + getSafeAreaBottom()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(getSafeAreaTop() + moderateScale(number: 24))
            $0.leading.trailing.equalToSuperview()
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(moderateScale(number: 8))
            $0.leading.trailing.equalToSuperview().inset(moderateScale(number: 20))
            $0.height.equalTo(moderateScale(number: 56))
        }
        
        searchKeywordView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(moderateScale(number: 4))
            $0.leading.trailing.equalToSuperview().inset(moderateScale(number: 20))
        }
        
        searchImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(moderateScale(number: 16))
            $0.centerY.equalToSuperview()
            $0.size.equalTo(moderateScale(number: 24))
        }
        
        searchedBookListView.snp.makeConstraints {
            $0.top.equalTo(searchKeywordView.snp.bottom).offset(moderateScale(number: 10))
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(moderateScale(number: -tabBarHeight))
        }
    }
    
    override func setupIfNeeded() {
        
    }
    
    private func bind() {
        viewModel.getErrorSubject()
            .mainSink { [weak self] error in
                CommonUtil.showAlertView(title: "error",
                                         description: error.localizedDescription,
                                         submitText: "확인",
                                         submitCompletion: nil)
            }.store(in: &cancelBag)
        
        viewModel.searchedBooksPublisher
            .droppedSink { [weak self] _ in
                guard let self = self else { return }
                searchedBookListView.reloadData()
            }.store(in: &cancelBag)
        
        viewModel.recentKeywordPublisher
            .droppedSink { [weak self] keywords in
                guard let self = self else { return }
                var searchKeywordViews: [UIView] = []
                for keyword in keywords {
                    let keywordView: PaddedView = PaddedView(vertical: 3, horizontal: 8).then {
                        $0.titleLabel.textColor = .systemGray
                        $0.titleLabel.attributedText = FontManager.body4M.setFont(keyword,
                                                                                  alignment: .center)
                        $0.backgroundColor = .systemGray5
                        $0.layer.masksToBounds = true
                        $0.layer.cornerRadius = moderateScale(number: 10)
                    }
                    keywordView.didTapped { [weak self] in
                        self?.searchTextField.text = keyword
                        self?.searchBooks(keyword: keyword)
                    }
                    searchKeywordViews.append(keywordView)
                }
                
                searchKeywordView.layoutIfNeeded()
                searchKeywordView.arrangeViews(searchKeywordViews)
            }.store(in: &cancelBag)
        
        viewModel.fetchRecentSearchKeyword()
    }
    
    private func searchBooks(keyword: String) {
        Task {
            do {
                CommonUtil.showLoadingView()
                try await viewModel.searchBooks(with: keyword)
                CommonUtil.hideLoadingView()
                self.storedKeyword = keyword
            } catch {}
        }
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] _, _ in
            guard let self = self else { return nil }
            let itemSize: NSCollectionLayoutSize
            
            if self.viewModel.searchedBooks?.items.isEmpty == true {
                itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1))
            } else {
                itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .absolute(moderateScale(number: 200)))
            }
            
            return CompositionalLayoutProvider.configureSectionLayout(withItemLayout: .init(size: itemSize),
                                                                      groupLayout: .init(size: itemSize),
                                                                      sectionLayout: .init())
        }
    }
    
    @objc
    private func textFieldDidChange(_ sender: UITextField) {
        guard let searchedText = sender.text else { return }
        
    }
    
    @objc
    private func handleTapGesture() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension SearchBooksMainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let searchKeyword = textField.text {
            searchBooks(keyword: searchKeyword)
        }
        return true
    }
}

extension SearchBooksMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let searchedBooks = viewModel.searchedBooks else { return 0 }
        
        if searchedBooks.items.isEmpty {
            collectionView.bounces = false
            return 1
        } else {
            collectionView.bounces = true
            return searchedBooks.items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let searchedBooks = viewModel.searchedBooks else { return .init() }
        
        if searchedBooks.items.isEmpty {
            guard let cell = collectionView.dequeueReusableCell(NoSearchDataCell.self, indexPath: indexPath) else { return .init() }
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(BookCell.self, indexPath: indexPath) else { return .init() }
            
            let book: Book.Entity.BookItem = searchedBooks.items[indexPath.item]
            cell.updateView(with: book)
            cell.containerView.didTapped { [weak self] in
                self?.coordinator?.moveToAnotherFlow(TabBarFlow.common(.bookDetail), userData: ["bookInfo": book])
            }
            
            return cell
        }
    }
}

extension SearchBooksMainViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//       
//        
//        if indexPath.item >= total - 3 {
//            searchBooks(keyword: storedKeyword)
//        }
//    }
}

