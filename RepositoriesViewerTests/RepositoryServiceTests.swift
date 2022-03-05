//
//  RepositoryServiceTests.swift
//  RepositoriesViewerTests
//
//  Created by Admin on 05.03.2022.
//

import Foundation
import XCTest
@testable import RepositoriesViewer

class RepositoryServiceTests: XCTestCase {
    func test_service_canFetchReposFromGithub() {
        let sut = RepositoryService()
        
        let exp = expectation(description: "wait for network response")
        sut.getRepositories(for: "PinLayout") { result in
            switch result {
            case .success(let repos):
                XCTAssertEqual(repos.count, 14)
                exp.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [exp], timeout: 3)
    }
}

