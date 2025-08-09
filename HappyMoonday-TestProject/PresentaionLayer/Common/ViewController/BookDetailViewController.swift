//
//  BookDetailViewController.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import UIKit
import SnapKit
import Then
import Combine

final class BookDetailViewController: BaseNavigationViewController, CommonCoordinated {
    private var cancelBag = Set<AnyCancellable>()
    var coordinator: AnyCommonCoordinator?
    
    private let viewModel: BookDetailViewModel
    
    init(viewModel: BookDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        // Do any additional setup after loading the view.
        
        bind()
    }
    
    override func addViews() {
        super.addViews()
    }
    
    override func makeConstraints() {
        super.makeConstraints()
    }
    
    override func setupIfNeeded() {
        super.setupIfNeeded()
    }
    
    private func bind() {
        viewModel.getErrorSubject()
            .mainSink { [weak self] error in
                CommonUtil.showAlertView(title: "error",
                                         description: error.localizedDescription,
                                         submitText: "확인",
                                         submitCompletion: nil)
            }.store(in: &cancelBag)
    }
}
