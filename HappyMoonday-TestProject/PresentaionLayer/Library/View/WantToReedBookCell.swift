//
//  WantToReedBookCell.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/10/25.
//

import UIKit
import Then
import SnapKit

final class WantToReedBookCell: UICollectionViewCell {
    private(set) lazy var containerView: TouchableView = TouchableView().then {
        $0.layer.cornerRadius = moderateScale(number: 6)
        $0.layer.masksToBounds = true
        $0.backgroundColor = .systemGray6
        $0.layer.borderColor = UIColor.systemGray6.cgColor
        $0.layer.borderWidth = 1
    }
    
    private lazy var bookImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var bookInfoView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var bookInfoStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = moderateScale(number: 4)
        $0.backgroundColor = .white
    }
    
    private lazy var bookTitleLabel: UILabel = UILabel().then {
        $0.attributedText = FontManager.body3M.setFont(alignment: .left)
        $0.textColor = .black
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
    }
    
    private lazy var linkLabel: UILabel = UILabel().then {
        $0.attributedText = FontManager.body4M.setFont("구매처 바로가기",
                                                       alignment: .left)
        $0.textColor = .systemCyan
    }
    
    private lazy var discountLabel: UILabel = UILabel().then {
        $0.attributedText = FontManager.body2SB.setFont(alignment: .left)
        $0.textColor = .black
        $0.numberOfLines = 1
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
                                   bookInfoView])
        bookInfoView.addSubview(bookInfoStackView)
        bookInfoStackView.addArrangedSubviews([bookTitleLabel,
                                               linkLabel,
                                               discountLabel])
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        bookImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(moderateScale(number: 10))
            $0.height.equalTo(moderateScale(number: 100))
            $0.width.equalTo(moderateScale(number: 80))
            $0.centerX.equalToSuperview()
        }
        bookInfoView.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(moderateScale(number: 12))
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        bookInfoStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(moderateScale(number: 6))
            $0.leading.trailing.equalToSuperview().inset(moderateScale(number: 6))
        }
    }
    
    func updateView(with book: Book.Entity.BookItem) {
        bookImageView.setImageWithSpinner(
            urlString: book.image,
            placeholder: UIImage(systemName: "photo")
        )
        bookTitleLabel.text = book.title
        discountLabel.text = "\(book.discount)₩"
    }
}
