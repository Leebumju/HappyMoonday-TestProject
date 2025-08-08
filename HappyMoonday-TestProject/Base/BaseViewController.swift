//
//  BaseViewController.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        addViews()
        makeConstraints()
        setupIfNeeded()
    }
    
    deinit {
        deinitialize()
    }
    
    func addViews() {}
    
    func makeConstraints() {}
    
    func setupIfNeeded() {}
    
    func deinitialize() {}
}
