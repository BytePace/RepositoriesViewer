//
//  RepositoriesListInteractorTests.swift
//  RepositoriesViewerTests
//
//  Created by Admin on 05.03.2022.
//

import Foundation
@testable import RepositoriesViewer
import XCTest

class RepositoriesListInteractorTests: XCTestCase {
    func test_interactor_returnsRepositoriesFromRepositoryService() {
        let sut = RepositoriesListInteractor(service: FakeRepositoryService([FakeRepository(), FakeRepository(), FakeRepository()]))

        let state = StateSpy<[RepositoryProtocol]>(sut.searchRepositories(for: "").asObservable())

        XCTAssertEqual(state.values.first?.count, 3)
    }

//    private func makeSUT(_ service: FakeRepositoryService) -> RepositoriesListInteractor {
//        RepositoriesListInteractor(service: service)
//    }
}

struct FakeRepositoryService: RepositoryServiceProtocol {
    init(_ repos: [RepositoryProtocol]) {
        self.repos = repos
    }
    func getRepositories(for text: String, completion: ((Result<[RepositoryProtocol], Error>) -> Void)?) {
        completion?(.success(repos))
    }
    
    var repos: [RepositoryProtocol]
}
