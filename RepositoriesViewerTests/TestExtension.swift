//
//  TestExtension.swift
//  RepositoriesViewerTests
//
//  Created by Admin on 05.03.2022.
//

import Foundation
import UIKit

extension UIView {
    func renderOnWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.addSubview(self)
        frame = window.bounds
        setNeedsLayout()
        layoutIfNeeded()
    }
}

extension UIViewController{
    func renderOnWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = self
        window.addSubview(view)
        view.frame = window.bounds
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

import RxSwift

class StateSpy<T> {
    private (set) var values = [T]()
    private let disposeBag = DisposeBag()
    
    init(_ observable: Observable<T>) {
        observable.subscribe(onNext: { [weak self] in
            self?.values.append($0)
        })
        .disposed(by: disposeBag)
    }
    
}

