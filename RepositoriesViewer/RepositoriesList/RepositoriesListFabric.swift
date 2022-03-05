//
//  RepositoriesListFabric.swift
//  RepositoriesViewer
//
//  Created by Admin on 05.03.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

final class RepositoriesListFabric {
    class func assembledScreen(_ router: RepositoriesListRouter = .init()) -> RepositoriesListViewController {
        let interactor = RepositoriesListInteractor()
        let presenter = RepositoriesListPresenter(router, interactor)
        let viewController = RepositoriesListViewController(presenter)
        router.viewController = viewController
        return viewController
    }
}
