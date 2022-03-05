//
//  RepositoriesListRouter.swift
//  RepositoriesViewer
//
//  Created by Admin on 05.03.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

final class RepositoriesListRouter: Router<RepositoriesListViewController>, RepositoriesListRouter.Routes {

    typealias Routes = Any
}

protocol RepositoriesListRoute {
    var openRepositoriesListTransition: Transition { get }
    func openRepositoriesList()
}
extension RepositoriesListRoute where Self: RouterProtocol {
    func openRepositoriesList() {
        let router = RepositoriesListRouter()
        let viewController = RepositoriesListFabric.assembledScreen(router)
        openWithNextRouter(viewController, nextRouter: router, transition: openRepositoriesListTransition)
    }
}
