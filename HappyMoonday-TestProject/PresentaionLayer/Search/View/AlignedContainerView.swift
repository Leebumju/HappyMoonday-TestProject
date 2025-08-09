//
//  AlignedContainerView.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import UIKit
import Then
import SnapKit

final class AlignedContainerView: UIView {
    private lazy var containerStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fillProportionally
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func arrangeViews(_ subViews: [UIView], spacing: CGFloat = moderateScale(number: 4)) {
        containerStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        containerStackView.spacing = spacing
        
        var horizontalStackView = UIStackView()
        horizontalStackView.spacing = spacing
        
        var currentRowWidth: CGFloat = 0
        
        for subView in subViews {
            let subViewWidth: CGFloat = subView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
            
            if horizontalStackView.arrangedSubviews.isEmpty || (currentRowWidth + spacing + subViewWidth <= self.bounds.width) {
                horizontalStackView.addArrangedSubview(subView)
                currentRowWidth += subViewWidth + spacing
            } else {
                containerStackView.addArrangedSubview(horizontalStackView)
                horizontalStackView = UIStackView()
                horizontalStackView.spacing = spacing
                horizontalStackView.addArrangedSubview(subView)
                currentRowWidth = subViewWidth + spacing
            }
        }
        
        if !horizontalStackView.arrangedSubviews.isEmpty {
            containerStackView.addArrangedSubview(horizontalStackView)
        }
    }
}
