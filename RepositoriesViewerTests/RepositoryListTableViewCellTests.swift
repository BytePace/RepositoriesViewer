//
//  RepositoryListTableViewCellTests.swift
//  RepositoriesViewerTests
//
//  Created by Admin on 05.03.2022.
//

import Foundation
import UIKit
import XCTest

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

class RepositoryListTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    let linkLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(linkLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviews()
    }
    
    private func configureSubviews() {
        titleLabel.pin
            .top()
            .horizontally(8)
            .sizeToFit(.width)
        
        linkLabel.pin
            .below(of: titleLabel)
            .marginTop(4)
            .horizontally(8)
            .sizeToFit(.width)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = size
        contentView.pin.size(size)
        configureSubviews()
        size.height = linkLabel.frame.maxY + 8
        return size
    }
}
