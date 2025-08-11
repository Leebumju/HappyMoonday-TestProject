//
//  SplashViewController.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import UIKit
import SnapKit
import Then

class SplashViewController: BaseViewController, AppCoordinated {
    
    var coordinator: AnyAppCoordinator?
    
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.text = "Splash View"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func addViews() {
        super.addViews()
        view.addSubview(titleLabel)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func setupIfNeeded() {
        super.setupIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.coordinator?.moveTo(.tabBar(.library(.main)), userData: nil)
        }
    }
}

