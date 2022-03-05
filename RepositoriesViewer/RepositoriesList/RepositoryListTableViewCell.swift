//
//  RepositoryListTableViewCell.swift
//  RepositoriesViewer
//
//  Created by Admin on 05.03.2022.
//

import Foundation
import UIKit

class RepositoryListTableViewCell: UITableViewCell {
    var viewModel: RepositoryListViewProtocol! {
        didSet {
            titleLabel.text = viewModel.title
            linkLabel.text = viewModel.link
        }
    }
    
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

