//
//  LibaryMainViewController.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import UIKit
import SnapKit
import Then
import Combine

final class LibraryMainViewController: BaseViewController{
    private var cancelBag = Set<AnyCancellable>()
    var coordinator: AnyLibraryCoordinator?
    
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.attributedText = FontManager.title2SB.setFont("책 보관함",
                                                         alignment: .center)
    }
    
    private lazy var bookListView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.dataSource = self
        $0.showsVerticalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.registerCell(ReadingBookCell.self)
        $0.registerCell(BookCell.self)
        $0.registerCell(NoDataCell.self)
        $0.registerSupplimentaryView(ReadingBookHeaderView.self, supplementaryViewOfKind: .header)
        $0.registerSupplimentaryView(FavoriteBookHeaderView.self, supplementaryViewOfKind: .header)
    }
    
    private let viewModel: LibraryMainViewModel
    
    init(viewModel: LibraryMainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CommonUtil.showLoadingView()
        bind()
    }
    
    override func addViews() {
        view.addSubviews([titleLabel,
                          bookListView])
    }
    
    override func makeConstraints() {
        let tabBarHeight: CGFloat = tabBarController?.tabBar.bounds.height ?? moderateScale(number: 48) + getSafeAreaBottom()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(getSafeAreaTop() + moderateScale(number: 24))
            $0.leading.trailing.equalToSuperview()
        }
        
        bookListView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(moderateScale(number: 20))
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(moderateScale(number: -tabBarHeight))
        }
    }
    
    override func setupIfNeeded() {
        setupNotifications()
    }
    
    override func deinitialize() {
        NotificationCenter.default.removeObserver(self,
                                                  name: .bookCategoryIsUpdated,
                                                  object: nil)
    }
    
    private func bind() {
        viewModel.getErrorSubject()
            .mainSink { [weak self] error in
                CommonUtil.showAlertView(title: "error",
                                         description: error.localizedDescription,
                                         submitText: "확인",
                                         submitCompletion: nil)
            }.store(in: &cancelBag)
        
        viewModel.allBooksPublisher
            .mainSink { [weak self] _ in
                guard let self = self else { return }
                bookListView.reloadData()
                CommonUtil.hideLoadingView()
            }.store(in: &cancelBag)
        
        viewModel.fetchAllBooksCategory()
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            switch sectionIndex {
            case 0:
                guard let self = self else { return nil }
                
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(moderateScale(number: 200))
                )
                
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(moderateScale(number: 46))
                )

                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )

                let sectionLayout = NSCollectionLayoutSection(
                    group: NSCollectionLayoutGroup.horizontal(
                        layoutSize: groupSize,
                        subitems: [NSCollectionLayoutItem(layoutSize: itemSize)]
                    )
                )
                
                sectionLayout.boundarySupplementaryItems = [header]
                sectionLayout.orthogonalScrollingBehavior = .groupPagingCentered
                
                return sectionLayout
            case 1, 2:
                let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                              heightDimension: .absolute(moderateScale(number: 200)))
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                        heightDimension: .estimated(moderateScale(number: 46)))
                return CompositionalLayoutProvider.configureSectionLayout(withItemLayout: .init(size: itemSize),
                                                                          groupLayout: .init(size: itemSize),
                                                                          sectionLayout: .init(headerSize: headerSize))
            default: return nil
            }
        }
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleBookCategoryChanged),
                                               name: .bookCategoryIsUpdated,
                                               object: nil)
    }
    
    
    @objc private func handleBookCategoryChanged(_ notification: Notification) {
        if let category = notification.userInfo?["bookCategory"] as? BookCategory {
            viewModel.fetchBooksCategory(with: category)
        }
    }
}

extension LibraryMainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            guard let readingHeaderView = collectionView.dequeueSupplimentaryView(ReadingBookHeaderView.self,
                                                                                  supplementaryViewOfKind: .header,
                                                                                  indexPath: indexPath) else { return .init() }
           return readingHeaderView
        case 1:
            guard let favoriteBookHeaderView = collectionView.dequeueSupplimentaryView(FavoriteBookHeaderView.self,
                                                                                  supplementaryViewOfKind: .header,
                                                                                  indexPath: indexPath) else { return .init() }
            favoriteBookHeaderView.updateView(with: "읽고 싶은 책 보관함")
           return favoriteBookHeaderView
        case 2:
            guard let favoriteBookHeaderView = collectionView.dequeueSupplimentaryView(FavoriteBookHeaderView.self,
                                                                                  supplementaryViewOfKind: .header,
                                                                                  indexPath: indexPath) else { return .init() }
            favoriteBookHeaderView.updateView(with: "읽은 책 보관함")
           return favoriteBookHeaderView
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            if viewModel.readingBooks.isEmpty {
                return 1
            } else {
                return viewModel.readingBooks.count
            }
        case 1:
            if viewModel.wantToReadBooks.isEmpty {
                return 1
            } else {
                return viewModel.wantToReadBooks.count
            }
        case 2:
            if viewModel.readDoneBooks.isEmpty {
                return 1
            } else {
                return viewModel.readDoneBooks.count
            }
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if viewModel.readingBooks.isEmpty {
                guard let cell = collectionView.dequeueReusableCell(NoDataCell.self, indexPath: indexPath) else { return .init() }
                cell.containerStackView.didTapped { [weak self] in
                    self?.coordinator?.moveToAnotherFlow(TabBarFlow.search(.main), userData: nil)
                }
                cell.updateView(with: .reading)
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(ReadingBookCell.self, indexPath: indexPath) else { return .init() }
                
                cell.updateView()
                return cell
            }
        case 1:
            if viewModel.wantToReadBooks.isEmpty {
                guard let cell = collectionView.dequeueReusableCell(NoDataCell.self, indexPath: indexPath) else { return .init() }
                cell.containerStackView.didTapped { [weak self] in
                    self?.coordinator?.moveToAnotherFlow(TabBarFlow.search(.main), userData: nil)
                }
                
                cell.updateView(with: .wantToRead)
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(BookCell.self, indexPath: indexPath) else { return .init() }
                
                cell.updateView(with: viewModel.wantToReadBooks[indexPath.item])
                return cell
            }
        case 2:
            if viewModel.readDoneBooks.isEmpty {
                guard let cell = collectionView.dequeueReusableCell(NoDataCell.self, indexPath: indexPath) else { return .init() }
                cell.containerStackView.didTapped { [weak self] in
                    self?.coordinator?.moveToAnotherFlow(TabBarFlow.search(.main), userData: nil)
                }
                
                cell.updateView(with: .readDone)
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(BookCell.self, indexPath: indexPath) else { return .init() }
                
                cell.updateView(with: viewModel.readDoneBooks[indexPath.item])
                return cell
            }
        default:
            return UICollectionViewCell()
        }
    }
}
