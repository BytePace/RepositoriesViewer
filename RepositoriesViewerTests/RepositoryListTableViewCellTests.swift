//
//  RepositoryListTableViewCellTests.swift
//  RepositoriesViewerTests
//
//  Created by Admin on 05.03.2022.
//

import Foundation
import XCTest

@testable import RepositoriesViewer

class RepositoryListTableViewCellTests: XCTestCase {
    func test_cell_canInit() {
        XCTAssertNotNil(RepositoryListTableViewCell())
    }
    
    func test_cell_hasTitleLabel() {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertEqual(sut.titleLabel.superview, sut.contentView)
        XCTAssertEqual(sut.titleLabel.frame.width, sut.contentView.frame.width - 8 * 2)
        XCTAssertNotEqual(sut.titleLabel.frame.height, 0)
    }
    
    func test_cell_hasLinkLabel() {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut.linkLabel)
        XCTAssertEqual(sut.linkLabel.superview, sut.contentView)
        XCTAssertEqual(sut.linkLabel.frame.width, sut.contentView.frame.width - 8 * 2)
        XCTAssertNotEqual(sut.linkLabel.frame.height, 0)
    }
    
    func test_cellSizeThatFitsHeight_equalToLinkLabelFrameMaxYPlus8() {
        let sut = makeSUT()
        
        let calculatedSize = sut.sizeThatFits(.init(width: sut.frame.width, height: .greatestFiniteMagnitude))
        XCTAssertEqual(calculatedSize.height, sut.linkLabel.frame.maxY + 8)
    }
    
    func test_cellWithViewModel_displayesTitleAndLinkTextFromViewModel() {
        let sut = makeSUT()
        let vm = RepositoryListView(title: "Repo title", link: "Repo URL")
        sut.viewModel = vm

        XCTAssertEqual(sut.titleLabel.text, vm.title)
        XCTAssertEqual(sut.linkLabel.text, vm.link)
    }

    func test_cellWithLinkInTwoLinesHeight_biggerThanHeightOfCellWithOneLineLink() {
        let sut = makeSUT()
        let vm = RepositoryListView(title: "Repo title", link: "Repo URL\nRepo name2")
        sut.viewModel = vm
        
        let cell2 = makeSUT()
        let vm2 = RepositoryListView(title: "Repo title", link: "Repo URL")
        cell2.viewModel = vm2
        
        let h1 = sut.sizeThatFits(.init(width: sut.frame.width, height: .greatestFiniteMagnitude)).height
        
        let h2 = cell2.sizeThatFits(.init(width: sut.frame.width, height: .greatestFiniteMagnitude)).height
        
        XCTAssert(h1 > h2)

    }
    
    private func makeSUT() -> RepositoryListTableViewCell {
        let cell = RepositoryListTableViewCell()
        cell.titleLabel.text = "Repo name"
        cell.linkLabel.text = "Repo URL"
        
        cell.renderOnWindow()

        return cell
    }
}
