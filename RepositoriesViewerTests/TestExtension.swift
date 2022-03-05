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
