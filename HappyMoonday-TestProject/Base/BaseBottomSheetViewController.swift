//
//  BaseBottomSheetViewController.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/10/25.
//

import UIKit
import Then
import SnapKit

class BaseBottomSheetViewController: BaseViewController {
    var bottomConstraint: Constraint?
    
    private(set) lazy var backgroundView: TouchableView = TouchableView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.4)
        $0.alpha = 0
    }
    
    private(set) lazy var bottomSheetContainerView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = moderateScale(number: 20)
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.backgroundView.alpha = 1
            
            self?.bottomSheetContainerView.snp.remakeConstraints {
                $0.leading.trailing.equalToSuperview()
                self?.bottomConstraint = $0.bottom.equalToSuperview().constraint
            }
            
            self?.view.layoutIfNeeded()
        }
    }
    
    override func addViews() {
        view.addSubviews([backgroundView, bottomSheetContainerView])
    }
    
    override func makeConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheetContainerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.snp.bottom)
        }
    }
    
    override func setupIfNeeded() {
        backgroundView.didTapped { [weak self] in
            self?.dismissBottomSheet()
        }
    }
    
    func dismissBottomSheet(completion: (() -> Void)? = nil) {
        view.endEditing(true)
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            
            let viewHeight: CGFloat = self.bottomSheetContainerView.frame.height
            
            self.backgroundView.alpha = 0
            self.bottomConstraint?.update(offset: viewHeight)
            
            self.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.dismiss(animated: false, completion: completion)
        }
    }
}
