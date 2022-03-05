//
//  RepositoriesListInteractor.swift
//  RepositoriesViewer
//
//  Created by Admin on 05.03.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import RxCocoa
import Foundation

protocol RepositoriesListInteractorProtocol {
    var service: RepositoryServiceProtocol { get }
    func searchRepositories(for text: String) -> Single<[RepositoryProtocol]>
}

protocol RepositoryServiceProtocol {
    func getRepositories(for text: String, completion: ((Result<[RepositoryProtocol], Error>) -> Void)?)
}

final class RepositoriesListInteractor: RepositoriesListInteractorProtocol {
    let service: RepositoryServiceProtocol
    private let disposeBag = DisposeBag()

    init(service: RepositoryServiceProtocol) {
        self.service = service
    }
    
    func searchRepositories(for text: String) -> Single<[RepositoryProtocol]> {
        Single<[RepositoryProtocol]>.create { [weak self] single in
            self?.service.getRepositories(for: text, completion: {
                switch $0 {
                case .success(let repos):
                    single(.success(repos))
                case .failure(let error):
                    single(.failure(error))
                }
            })
            return Disposables.create()
        }
    }
}


protocol RepositoryProtocol: Decodable {
    var title: String { get set }
    var link: URL { get set }
}

struct Repository: RepositoryProtocol {
    var title: String
    var link: URL

    enum CodingKeys: String, CodingKey {
        case title = "name"
        case link = "url"
    }

}
