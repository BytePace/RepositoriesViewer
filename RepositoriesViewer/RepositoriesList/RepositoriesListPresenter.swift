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
    var debounceTime: RxTimeInterval = .seconds(1)
    var router: Router<RepositoriesListViewController>
    private let interactor: RepositoriesListInteractorProtocol
    
    private let repositories = BehaviorRelay<[RepositoryListViewProtocol]>(value: [])
    
    private let disposeBag = DisposeBag()

    init(_ router: Router<RepositoriesListViewController>, _ interactor: RepositoriesListInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension RepositoriesListPresenter: RepositoriesListPresenterProtocol {
    struct Input {
        let searchText: Observable<String>
    }

    struct Output {
        let repositories: Driver<[RepositoryListViewProtocol]>
    }

    func bindInput(_ input: RepositoriesListPresenter.Input) {
        input.searchText
            .debounce(debounceTime, scheduler: MainScheduler.instance)
            .flatMapLatest { [unowned self] in
                self.interactor.searchRepositories(for: $0)
                    .asObservable()
                    .do(onError: { error in
                        print(error.localizedDescription)
                    })
                    .catchAndReturn([])
            }
            .map {
                $0.map {
                    RepositoryListView(title: $0.title , link: $0.link.absoluteString)
                }
            }
            .bind(to: repositories)
            .disposed(by: disposeBag)
    }

    func configureOutput(_ input: RepositoriesListPresenter.Input) -> RepositoriesListPresenter.Output {
        return Output(repositories: repositories.asDriver())
    }
}
