//
//  SingleTextBottomSheetViewController.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/10/25.
//

import UIKit
import Then
import SnapKit

protocol SingleTextBottomSheetViewControllerDelegate: AnyObject {
    func didSelectText(text: String)
}

final class SingleTextBottomSheetViewController: BaseBottomSheetViewController {
    weak var delegate: SingleTextBottomSheetViewControllerDelegate?
    
    private lazy var topContainerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.attributedText = FontManager.title2B.setFont("항목",
                                                        alignment: .left)
        $0.textColor = .black
    }
    
    private lazy var closeButton = TouchableView()
    
    private lazy var closeImageView = UIImageView().then {
        $0.image = UIImage(systemName: "xmark")?.withTintColor(.black,
                                                               renderingMode: .alwaysOriginal)
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var selectableListView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.registerCell(SelectableItemCell.self)
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.dataSource = self
    }
    
    private let selectableList: [String]
    
    init(selectableList: [String]) {
        self.selectableList = selectableList
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addViews() {
        super.addViews()
        
        bottomSheetContainerView.addSubviews([topContainerView,
                                              selectableListView])
        
        topContainerView.addSubviews([titleLabel, closeButton])
        closeButton.addSubview(closeImageView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        topContainerView.snp.makeConstraints {
            $0.top.equalTo(bottomSheetContainerView.snp.bottom).offset(moderateScale(number: 4))
            $0.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(moderateScale(number: 20))
            $0.top.bottom.equalToSuperview().inset(moderateScale(number: 12))
            $0.trailing.equalTo(closeButton.snp.leading).offset(-moderateScale(number: 11))
        }
        
        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(moderateScale(number: 15))
            $0.centerY.equalTo(titleLabel)
            $0.size.equalTo(moderateScale(number: 5 + 24 + 5))
        }
        
        closeImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(moderateScale(number: 24))
        }
        
        selectableListView.snp.makeConstraints {
            var viewHeight: CGFloat = 56 * CGFloat(selectableList.count)
            let maxHeight: CGFloat = view.bounds.height - getSafeAreaTop() - getDefaultSafeAreaBottom() - moderateScale(number: 30 + 54)
            viewHeight = min(moderateScale(number: viewHeight) + getSafeAreaBottom(), maxHeight)
            
            $0.top.equalTo(topContainerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(viewHeight)
            $0.bottom.equalToSuperview().inset(getSafeAreaBottom())
        }
    }
    
    override func setupIfNeeded() {
        super.setupIfNeeded()
        
        closeButton.didTapped { [weak self] in
            self?.dismissBottomSheet()
        }
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                      heightDimension: .estimated(moderateScale(number: 56)))
        
        return CompositionalLayoutProvider.configureLayout(withItemLayout: .init(size: itemSize),
                                                           groupLayout: .init(size: itemSize),
                                                           sectionLayout: .init())
    }
    
    private func calculateListViewHeight() -> CGFloat {
        let viewHeight: CGFloat = 56 * CGFloat(selectableList.count)
        let maxHeight: CGFloat = view.bounds.height - getSafeAreaTop() - getDefaultSafeAreaBottom() - moderateScale(number: 30 + 54 + 44)
        return min(moderateScale(number: viewHeight) + getSafeAreaBottom(), maxHeight)
    }
}

// MARK: - UICollectionViewDataSource
extension SingleTextBottomSheetViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectableList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(SelectableItemCell.self, indexPath: indexPath) else { return .init() }
        
        let selectedText: String = selectableList[indexPath.item]
        cell.updateView(with: selectedText)
        
        cell.containerView.didTapped { [weak self] in
            guard let self = self else { return }
            self.dismissBottomSheet { [weak self] in
                guard let self = self else { return }
                self.delegate?.didSelectText(text: selectedText)
            }
        }
        
        return cell
    }
}
