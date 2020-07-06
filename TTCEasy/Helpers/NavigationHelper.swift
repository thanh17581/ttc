//
//  NavigationHelper.swift
//  TTCFaceID
//
//  Created by TrungNV on 3/11/20.
//  Copyright © 2020 ttc-solutions. All rights reserved.
//

import UIKit

final class NavigationHelper {
    static func setRoot(withVC viewcontroller: UIViewController) {
        let appNav = UINavigationController()
        appNav.viewControllers = [viewcontroller]
        UIApplication.shared.keyWindow?.rootViewController = appNav
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }

    static func createViewController(fromXIBType type: BaseVC.Type) -> BaseVC {
        return type.init()
    }
}
