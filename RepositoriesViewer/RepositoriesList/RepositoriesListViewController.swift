//
//  RepositoriesListViewController.swift
//  RepositoriesViewer
//
//  Created by Admin on 05.03.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift

final class RepositoriesListViewController: UIViewController {
    private let _view: RepositoriesListView
    private var presenter: RepositoriesListPresenter
    
    private let disposeBag = DisposeBag()
    
    init(_ presenter: RepositoriesListPresenter) {
        _view = RepositoriesListView()
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = _view
    }
}


// MARK: - UI Bindings

extension RepositoriesListViewController {
    private func setupBindings() {
        let input = RepositoriesListPresenter.Input(searchText: _view.searchBar.rx.text.orEmpty.asObservable())
        let output = presenter.buildOutput(with: input)
        
        output.repositories
            .asObservable()
            .bind(onNext: { [weak _view] in
                _view?.list = $0
            })
            .disposed(by: disposeBag)
    }
}
