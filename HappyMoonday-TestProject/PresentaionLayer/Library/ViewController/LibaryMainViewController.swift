//
//  LibaryMainViewController.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import UIKit
import SnapKit
import Then
import Combine

final class LibraryMainViewController: BaseViewController{
    private var cancelBag = Set<AnyCancellable>()
    var coordinator: AnyLibraryCoordinator?
    
    private let viewModel: LibraryMainViewModel
    
    init(viewModel: LibraryMainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        
    }
    
    override func makeConstraints() {
        
    }
    
    override func setupIfNeeded() {
        searchBooks()
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
    
    private func searchBooks() {
        Task {
            do {
                try await viewModel.searchBooks()
            } catch {}
        }
    }
}
