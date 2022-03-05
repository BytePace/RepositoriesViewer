//
//  RepositoriesListPresenter.swift
//  RepositoriesViewer
//
//  Created by Admin on 05.03.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxCocoa
import RxSwift

protocol RepositoriesListPresenterProtocol: RxPresenter {
    var router: Router<RepositoriesListViewController> { get }
    func buildOutput(with input: RepositoriesListPresenter.Input) -> RepositoriesListPresenter.Output
}

final class RepositoriesListPresenter {
    
    var router: Router<RepositoriesListViewController>
    private let interactor: RepositoriesListInteractor
    
    private let disposeBag = DisposeBag()

    init(_ router: Router<RepositoriesListViewController>, _ interactor: RepositoriesListInteractor) {
        self.router = router
        self.interactor = interactor
    }
}

extension RepositoriesListPresenter: RepositoriesListPresenterProtocol {
    struct Input {}

    struct Output {}

    func bindInput(_ input: RepositoriesListPresenter.Input) {

    }

    func configureOutput(_ input: RepositoriesListPresenter.Input) -> RepositoriesListPresenter.Output {

        return Output()
    }
}
