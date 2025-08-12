//
//  Untitled.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

//case reading
//case wantToRead
//case readDone

import UIKit
import Then
import SnapKit

final class ReadingBookCell: UICollectionViewCell {
    private(set) lazy var containerView: TouchableView = TouchableView().then {
        $0.backgroundColor = UIColor(
            red: .random(in: 0.5...1),
            green: .random(in: 0.5...1),
            blue: .random(in: 0.5...1),
            alpha: 1.0
        )
    }
    
    private lazy var bookImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private(set) lazy var editButton: TouchableImageView = TouchableImageView(frame: .zero).then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "minus.circle.fill")?.withTintColor(.red,
                                                                           renderingMode: .alwaysOriginal)
    }
    
    private lazy var containerStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = moderateScale(number: 6)
    }
    
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.attributedText = FontManager.body2B.setFont(alignment: .center)
        $0.numberOfLines = 0
    }
    
    private lazy var descriptionLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.attributedText = FontManager.body3M.setFont(alignment: .left)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byTruncatingTail
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
                                   editButton,
                                   containerStackView])
        containerStackView.addArrangedSubviews([titleLabel,
                                                descriptionLabel])
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bookImageView.snp.makeConstraints {
            $0.width.equalTo(moderateScale(number: 100))
            $0.trailing.equalToSuperview().inset(moderateScale(number: 30))
            $0.top.bottom.equalToSuperview().inset(moderateScale(number: 25))
        }
        
        editButton.snp.makeConstraints {
            $0.size.equalTo(moderateScale(number: 24))
            $0.top.equalToSuperview().offset(moderateScale(number: 20))
            $0.trailing.equalToSuperview().offset(moderateScale(number: -20))
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(bookImageView).offset(moderateScale(number: 20))
            $0.leading.equalToSuperview().offset(moderateScale(number: 30))
            $0.trailing.equalTo(bookImageView.snp.leading).offset(moderateScale(number: -16))
            $0.bottom.lessThanOrEqualTo(bookImageView).offset(moderateScale(number: -20))
        }
    }
    
    func updateView(with book: Book.Entity.BookItem, isEditMode: Bool) {
        if book.image.isEmpty {
            bookImageView.image = UIImage(systemName: "photo")
        } else {
            bookImageView.setImageWithSpinner(
                urlString: book.image,
                placeholder: UIImage(systemName: "photo")
            )
        }
        editButton.isHidden = !isEditMode
        titleLabel.text = "\(book.title) (\(book.author))"
        titleLabel.highLightText(targetString: "(\(book.author))",
                                 color: .systemGray,
                                 font: FontManager.body4M.font)
        descriptionLabel.text = book.description
    }
}
