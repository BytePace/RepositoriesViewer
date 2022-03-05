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

    private func makeSUT() -> RepositoryListTableViewCell {
        let cell = RepositoryListTableViewCell()
        cell.titleLabel.text = "Repo name"
        cell.linkLabel.text = "Repo URL"
        
        cell.renderOnWindow()

        return cell
    }
}
