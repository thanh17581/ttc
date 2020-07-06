//
//  PopupHelper.swift
//  Tecomen
//
//  Created by TrungNV on 3/16/20.
//  Copyright © 2020 ttc-solutions. All rights reserved.
//

import UIKit
import STPopup

class PopupHeler {
    static func showPopup(in vc: UIViewController, withVC contentVC: UIViewController, withSize contentSize: CGSize, withTitle title: String = "popup.title.default".localized) {
        contentVC.contentSizeInPopup = contentSize
        let popupController = STPopupController(rootViewController: contentVC)
        let blur = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView.init(effect: blur)
        popupController.backgroundView = visualEffectView
        popupController.containerView.layer.cornerRadius = 8

        STPopupNavigationBar.appearance().barTintColor = .white
        STPopupNavigationBar.appearance().tintColor = Colors.leftColor
        STPopupNavigationBar.appearance().barStyle = .default
        STPopupNavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        STPopupNavigationBar.appearance().shadowImage = UIImage()
        STPopupNavigationBar.appearance().titleTextAttributes = [
            .font: UIFont(name: "Roboto-medium", size: 18) ?? .systemFont(ofSize: 18),
            .foregroundColor: Colors.leftColor,
        ]

        contentVC.title = title
        popupController.present(in: vc)

    }
}
