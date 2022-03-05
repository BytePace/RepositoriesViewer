//
//  RepositoriesListView.swift
//  RepositoriesViewer
//
//  Created by Admin on 05.03.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import PinLayout

protocol RepositoryListViewProtocol {
    var title: String { get set }
    var link: String { get set }
}

struct RepositoryListView: RepositoryListViewProtocol {
    var title: String
    var link: String
}

class RepositoriesListView: UIView {
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
        tableView.register(RepositoryListTableViewCell.self, forCellReuseIdentifier: String(describing: RepositoryListTableViewCell.self))
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

extension RepositoriesListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryListTableViewCell.self), for: indexPath) as! RepositoryListTableViewCell
        cell.viewModel = list[indexPath.row]
        return cell
    }
}

