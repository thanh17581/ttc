//
//  NavigationExtension.swift
//  Tecomen
//
//  Created by TrungNV on 3/17/20.
//  Copyright © 2020 ttc-solutions. All rights reserved.
//

import UIKit

extension UINavigationController {
    func makeTransparent() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        view.backgroundColor = .clear
    }
}
