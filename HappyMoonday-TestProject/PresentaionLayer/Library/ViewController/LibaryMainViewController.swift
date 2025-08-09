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
        $0.text = "책"
    }
    
    private lazy var bookListView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.dataSource = self
        $0.showsVerticalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.registerCell(ReadingBookCell.self)
        $0.registerCell(BookCell.self)
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
                print(viewModel.readingBooks)
                print(viewModel.wantToReadBooks)
                print(viewModel.readDoneBooks)
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
                
                let sectionLayout = NSCollectionLayoutSection(
                    group: NSCollectionLayoutGroup.horizontal(
                        layoutSize: groupSize,
                        subitems: [NSCollectionLayoutItem(layoutSize: itemSize)]
                    )
                )
                
                sectionLayout.orthogonalScrollingBehavior = .groupPagingCentered
                
                return sectionLayout
            case 1, 2:
                let itemSize: NSCollectionLayoutSize
                itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .absolute(moderateScale(number: 200)))
                
                return CompositionalLayoutProvider.configureSectionLayout(withItemLayout: .init(size: itemSize),
                                                                          groupLayout: .init(size: itemSize),
                                                                          sectionLayout: .init())
            default: return nil
            }
        }
    }
}

extension LibraryMainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        switch indexPath.section {
//        case 0:
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(ReadingBookCell.self, indexPath: indexPath) else { return .init() }
        
        cell.updateView()
        return cell
    }
}
