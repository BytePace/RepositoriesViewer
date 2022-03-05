//
//  RepositoriesViewTests.swift
//  RepositoriesViewerTests
//
//  Created by Admin on 05.03.2022.
//

import Foundation
import XCTest
import UIKit
import PinLayout

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

    private func makeSUT() -> RepositoriesView {
        let view = RepositoriesView()
        view.renderOnWindow()
        return view
    }
}

protocol RepositoryListViewProtocol {
    var title: String { get set }
    var link: String { get set }
}

struct RepositoryListView: RepositoryListViewProtocol {
    var title: String
    var link: String
}

class RepositoriesView: UIView {
    let searchBar = UISearchBar()
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        return view
    }()
    
    var list: [RepositoryListViewProtocol] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(searchBar)
        addSubview(tableView)
        tableView.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureSubviews()
    }
    
    private func configureSubviews() {
        searchBar.pin
            .top()
            .horizontally()
            .sizeToFit(.width)
        
        tableView.pin
            .below(of: searchBar)
            .horizontally()
            .bottom()
    }
}

extension RepositoriesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
