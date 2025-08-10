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
    
    private(set) lazy var reportButton: TouchableImageView = TouchableImageView(frame: .zero).then {
        $0.image = UIImage(systemName: "pencil")?.withTintColor(.systemGray,
                                                                renderingMode: .alwaysOriginal)
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var containerStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = moderateScale(number: 6)
    }

    private lazy var titleStackView: UIStackView = UIStackView().then {
        $0.spacing = moderateScale(number: 4)
        $0.alignment = .leading
        $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
        $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.attributedText = FontManager.body2B.setFont(alignment: .left)
        $0.numberOfLines = 0
    }
    
    private lazy var authorLabel: UILabel = UILabel().then {
        $0.textColor = .systemGray
        $0.attributedText = FontManager.body4M.setFont(alignment: .left)
    }
    
    private lazy var descriptionLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.attributedText = FontManager.body3M.setFont(alignment: .left)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byTruncatingTail
        $0.setContentHuggingPriority(.defaultLow, for: .vertical)
        $0.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    private lazy var dividerView: UIView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(containerView)
        containerView.addSubviews([bookImageView,
                                   reportButton,
                                   containerStackView,
                                   dividerView])
        containerStackView.addArrangedSubviews([titleStackView,
                                                descriptionLabel])
        titleStackView.addArrangedSubviews([titleLabel,
                                            authorLabel])
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        reportButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(moderateScale(number: 16))
            $0.trailing.equalToSuperview().offset(moderateScale(number: -20))
            $0.size.equalTo(moderateScale(number: 24))
        }
        
        bookImageView.snp.makeConstraints {
            $0.width.equalTo(moderateScale(number: 100))
            $0.leading.equalToSuperview().inset(moderateScale(number: 30))
            $0.top.bottom.equalToSuperview().inset(moderateScale(number: 25))
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(bookImageView).offset(moderateScale(number: 20))
            $0.leading.equalTo(bookImageView.snp.trailing).offset(moderateScale(number: 16))
            $0.trailing.equalToSuperview().offset(moderateScale(number: -30))
            $0.bottom.equalTo(bookImageView).offset(moderateScale(number: -20))
        }
        
        dividerView.snp.makeConstraints {
            $0.height.equalTo(moderateScale(number: 2))
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func updateView(with book: Book.Entity.BookItem, isReadDone: Bool = false) {
        bookImageView.setImageWithSpinner(
            urlString: book.image,
            placeholder: UIImage(systemName: "photo")
        )
        titleLabel.text = book.title
        authorLabel.text = book.author
        descriptionLabel.text = book.description
        reportButton.isHidden = !isReadDone
    }
}
