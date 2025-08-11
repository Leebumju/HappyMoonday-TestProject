//
//  BaseWebViewController.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/10/25.
//

import UIKit
import WebKit
import Then
import SnapKit

final class BaseWebViewController: BaseNavigationViewController {
    
    private lazy var webView = WKWebView().then {
        $0.allowsBackForwardNavigationGestures = true
        $0.scrollView.showsVerticalScrollIndicator = false
    }
    
    private let urlRequest: URLRequest
    
    init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
        super.init()
        hidesBottomBarWhenPushed = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openWebView()
    }
    
    override func addViews() {
        super.addViews()
        
        view.addSubview(webView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()

        webView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(getSafeAreaBottom())
        }
    }
    
    override func setupIfNeeded() {
        super.setupIfNeeded()
    }

    private func openWebView() {
        DispatchMain.async { [weak self] in
            guard let self = self else { return }
            self.webView.load(self.urlRequest)
        }
    }
}
