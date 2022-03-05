//
//  RepositoriesListPresenterTests.swift
//  RepositoriesViewerTests
//
//  Created by Admin on 05.03.2022.
//

import Foundation
@testable import RepositoriesViewer
import XCTest
import RxSwift
import RxRelay


class RepositoriesListPresenterTests: XCTestCase {
    func test_presenter_canInit() {
        XCTAssertNotNil(makeSUT())
    }

    func test_presenterOnInputSearchTextChanged_fetchesRepositoriesFromInteractor() {
        let sut = makeSUT(FakeRepositoriesListInteractor(service: FakeRepositoryService([FakeRepository(), FakeRepository()])))
        
        let searchTextRelay = BehaviorRelay<String>(value: "")
        let input = RepositoriesListPresenter.Input(searchText: searchTextRelay.asObservable())
        sut.bindInput(input)
        let output = sut.configureOutput(input)
        let state = StateSpy<[RepositoryListViewProtocol]>(output.repositories.asObservable())

        searchTextRelay.accept("123")

        let exp = expectation(description: "wait for debounce")
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            XCTAssertEqual(state.values.last?.count, 2)
            exp.fulfill()
        })
        wait(for: [exp], timeout: 0.01)
    }
    
    private func makeSUT(_ interactor: RepositoriesListInteractorProtocol = FakeRepositoriesListInteractor(service: FakeRepositoryService([]))) -> RepositoriesListPresenter {
        let presenter = RepositoriesListPresenter(RepositoriesListRouter(), interactor)
        presenter.debounceTime = .seconds(0)
        return presenter
    }
}

struct FakeRepositoriesListInteractor: RepositoriesListInteractorProtocol {
    var service: RepositoryServiceProtocol
    
    func searchRepositories(for text: String) -> Single<[RepositoryProtocol]> {
        Single<[RepositoryProtocol]>.create { single in

            service.getRepositories(for: text) {
                switch $0 {
                case .success(let repos):
                    single(.success(repos))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
}

