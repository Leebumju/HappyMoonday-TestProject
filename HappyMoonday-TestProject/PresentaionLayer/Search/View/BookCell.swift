//
//  BookCell.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import UIKit
import Then
import SnapKit

final class BookCell: UICollectionViewCell {
    private(set) lazy var containerView: TouchableView = TouchableView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var bookImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var labelStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = moderateScale(number: 10)
        $0.alignment = .center
    }
    
    private lazy var bookTitleLabel: UILabel = UILabel().then {
        $0.textColor = .systemGray
    }
    
    private lazy var authorLabel: UILabel = UILabel().then {
        $0.textColor = .systemGray2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(containerView)
        containerView.addSubviews([bookImageView,
                                   labelStackView])
        labelStackView.addArrangedSubviews([bookTitleLabel,
                                            authorLabel])

    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(moderateScale(number: 20))
            $0.top.bottom.equalToSuperview()
        }
        
        bookImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().offset(moderateScale(number: 5))
            $0.leading.equalToSuperview()
            $0.width.equalTo(moderateScale(number: 50))
        }
        
        labelStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(bookImageView.snp.trailing)
            $0.trailing.equalToSuperview()
        }
    }
    
    func updateView(with book: Book.Entity.BookItem) {
        bookImageView.setImageWithSpinner(
            urlString: book.image,
            placeholder: UIImage(systemName: "photo")
        )
        bookTitleLabel.text = book.title
        authorLabel.text = book.author
    }
}
