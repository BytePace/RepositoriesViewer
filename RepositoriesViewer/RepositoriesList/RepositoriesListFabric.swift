//
//  RepositoriesListFabric.swift
//  RepositoriesViewer
//
//  Created by Admin on 05.03.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import RxSwift
import Foundation

final class RepositoriesListFabric {
    class func assembledScreen(_ router: RepositoriesListRouter = .init()) -> RepositoriesListViewController {
        let interactor = RepositoriesListInteractor(service: RepositoryService())
        let presenter = RepositoriesListPresenter(router, interactor)
        let viewController = RepositoriesListViewController(presenter)
        router.viewController = viewController
        return viewController
    }
}


struct RepositoryService: RepositoryServiceProtocol {
    let disposeBag = DisposeBag()
    func getRepositories(for text: String, completion: ((Result<[RepositoryProtocol], Error>) -> Void)?) {
        URLSession.shared.rx
            .data(request: URLRequest(url: URL(string: "https://api.github.com/search/repositories?q=\(text)")!))
            .map {
                try JSONDecoder().decode(RepositoryResponse.self, from: $0)
            }
            .map {
                $0.items
            }
            .subscribe(onNext: {
                completion?(.success($0))
            }, onError: {
                print($0)
                completion?(.failure($0))
            })
            .disposed(by: disposeBag)
    }
}

struct RepositoryResponse: Decodable {
    let items: [Repository]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ContainerCodingKey.self)
        
        self.items = try container.decode([Repository].self, forKey: .items)
    }
    
    enum ContainerCodingKey: String, CodingKey {
        case items
    }
}
