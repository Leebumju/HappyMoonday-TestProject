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
    
    private lazy var containerStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = moderateScale(number: 6)
    }
    
    private lazy var titleStackView: UIStackView = UIStackView().then {
        $0.spacing = moderateScale(number: 4)
    }
    
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.attributedText = FontManager.body2B.setFont(alignment: .left)
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
                                   containerStackView])
        containerStackView.addArrangedSubviews([titleStackView,
                                                descriptionLabel])
        titleStackView.addArrangedSubviews([titleLabel,
                                            authorLabel])
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bookImageView.snp.makeConstraints {
            $0.width.equalTo(moderateScale(number: 100))
            $0.trailing.equalToSuperview().inset(moderateScale(number: 30))
            $0.top.bottom.equalToSuperview().inset(moderateScale(number: 20))
        }
        
        containerStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(moderateScale(number: 16))
            $0.trailing.equalTo(bookImageView.snp.leading).offset(moderateScale(number: -16))
            $0.height.equalTo(bookImageView)
        }
    }
    
    func updateView(with book: Book.Entity.BookItem) {
        bookImageView.setImageWithSpinner(
            urlString: book.image,
            placeholder: UIImage(systemName: "photo")
        )
        titleLabel.text = book.title
        authorLabel.text = book.author
        descriptionLabel.text = book.description
    }
}
