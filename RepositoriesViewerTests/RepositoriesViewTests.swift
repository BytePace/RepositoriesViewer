//
//  RepositoriesViewTests.swift
//  RepositoriesViewerTests
//
//  Created by Admin on 05.03.2022.
//

import Foundation
import XCTest

@testable import RepositoriesViewer

class RepositoriesViewTests: XCTestCase {
    func test_view_canInit() {
        XCTAssertNotNil(makeSUT())
    }

    func test_view_hasNonZeroSize() {
        let sut = makeSUT()

        XCTAssertTrue(sut.frame.width > 0)
        XCTAssertTrue(sut.frame.height > 0)
    }

    func test_view_hasSearchBar() {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut.searchBar)
        XCTAssertEqual(sut.searchBar.superview, sut)
        XCTAssertEqual(sut.searchBar.frame.width, sut.frame.width)
        XCTAssertEqual(sut.searchBar.frame.height, 56)
    }
    
    func test_view_hasTableView() {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut.tableView)
        XCTAssertEqual(sut.tableView.superview, sut)
        XCTAssertEqual(sut.tableView.frame.width, sut.frame.width)
        XCTAssertEqual(sut.tableView.frame.height, sut.frame.height - sut.searchBar.frame.maxY)
    }

    func test_viewWithArrayOfRepositories_hasNumberOfRowsEqualToRepositoriesArray() {
        let sut = makeSUT()
        
        sut.list = [RepositoryListView(title: "rep", link: "rep url"), RepositoryListView(title: "rep2", link: "rep2 url")]
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), sut.list.count)
    }
    
    func test_viewWithArrayOfRepositories_hasRepositoryListTableViewCellAsCell() {
        let sut = makeSUT()
        
        sut.list = [RepositoryListView(title: "rep", link: "rep url"), RepositoryListView(title: "rep2", link: "rep2 url")]

        XCTAssertNotNil(sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? RepositoryListTableViewCell)
    }
    
    func test_viewWithArrayOfRepositories_firstCellHasTitleTextEqualToFirstRepositoryName() throws {
        let sut = makeSUT()
        
        sut.list = [RepositoryListView(title: "rep", link: "rep url"), RepositoryListView(title: "rep2", link: "rep2 url")]

        let cell = try XCTUnwrap(sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? RepositoryListTableViewCell)
        XCTAssertEqual(cell.titleLabel.text, "rep")
    }
    
    func test_viewWithArrayOfRepositories_firstCellHasLinkLabelTextEqualToFirstRepositoryLink() throws {
        let sut = makeSUT()
        
        sut.list = [RepositoryListView(title: "rep", link: "rep url"), RepositoryListView(title: "rep2", link: "rep2 url")]

        let cell = try XCTUnwrap(sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? RepositoryListTableViewCell)
        XCTAssertEqual(cell.linkLabel.text, "rep url")
    }

    private func makeSUT() -> RepositoriesListView {
        let view = RepositoriesListView()
        view.renderOnWindow()
        return view
    }
}

