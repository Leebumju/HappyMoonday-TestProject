//
//  BaseNavigationViewController.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import UIKit
import Combine
import Then
import SnapKit

class BaseNavigationViewController: BaseViewController {
    private(set) lazy var topView: UIView = UIView()
    
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.lineBreakMode = .byTruncatingTail
        $0.attributedText = FontManager.body2SB.setFont(alignment: .left)
    }
    
    private(set) lazy var backButton = TouchableView()
    
    private(set) lazy var backImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.left")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        $0.contentMode = .scaleAspectFit
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        hidesBottomBarWhenPushed = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addViews() {
        view.addSubview(topView)
        topView.addSubviews([backButton,
                             titleLabel])
        backButton.addSubview(backImageView)
    }
    
    override func makeConstraints() {
        let buttonMargin: CGFloat = 5
        
        topView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(getSafeAreaTop())
            $0.height.equalTo(moderateScale(number: 48))
            $0.leading.trailing.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(moderateScale(number: 20 - buttonMargin))
            $0.centerY.equalToSuperview()
            $0.size.equalTo(moderateScale(number: buttonMargin + 24 + buttonMargin))
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(moderateScale(number: 8))
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(moderateScale(number: 20))
        }
        
        backImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(moderateScale(number: 24))
        }
    }
    
    override func setupIfNeeded() {
        backButton.didTapped { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func updateTitleLabel(with titleText: String) {
        titleLabel.text = titleText
    }
}
