//
//  RepositoriesListViewController.swift
//  RepositoriesViewerTests
//
//  Created by Admin on 05.03.2022.
//

import Foundation
import XCTest
@testable import RepositoriesViewer

class RepositoriesListViewControllerTests: XCTestCase {
    func test_viewController_updateViewWhenReceiveUpdateOnOutputFromPresenter() throws {
        let sut = makeSUT([FakeRepository()])

        let view = try XCTUnwrap(sut.view as? RepositoriesListView)
        view.searchBar.text = "123"
        view.searchBar.searchTextField.sendActions(for: UIControl.Event.valueChanged)
        let exp = expectation(description: "wait for debounce")
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            XCTAssertEqual(view.tableView.numberOfRows(inSection: 0), 1)
            exp.fulfill()
        })
        
        wait(for: [exp], timeout: 0.01)
    }
    
    private func makeSUT(_ repos: [RepositoryProtocol]) -> RepositoriesListViewController {
        let presenter = RepositoriesListPresenter(RepositoriesListRouter(), RepositoriesListInteractor(service: FakeRepositoryService(repos)))
        presenter.debounceTime = .seconds(0)
        let vc = RepositoriesListViewController(presenter)
        vc.renderOnWindow()
        return vc
    }
}

struct FakeRepository: RepositoryProtocol {
    var title: String = ""
    var link: URL = URL(string: "www.google.com")!
}
