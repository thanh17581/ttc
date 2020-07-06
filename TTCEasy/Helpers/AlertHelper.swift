//
//  AlertHelper.swift
//  TTCFaceID
//
//  Created by TrungNV on 3/10/20.
//  Copyright © 2020 ttc-solutions. All rights reserved.
//

import UIKit

enum AlertType {
    case NONE
    case SUCCESS
    case FAIL
}

struct AlertButton {
    var title: String?
    var action: (() -> Void)?
}

struct AlertData {
    var type: AlertType = .NONE
    var image: UIImage?
    var title: String?
    var subText: String?
    var button1: AlertButton?
    var button2: AlertButton?
    var subTextColor: UIColor?
}

final class AlertBuilder {
    private var alertData: AlertData

    init() {
        alertData = AlertData()
    }

    func show() {
        let alert = TAlertView(title: alertData.title, msg: alertData.subText ?? " ", msgColor: alertData.subTextColor, image: alertData.image, button1: alertData.button1, button2: alertData.button2)
        alert.show()
    }

    func build() -> AlertData {
        return alertData
    }

    func setType(_ type: AlertType) -> AlertBuilder {
        alertData.type = type
        return self
    }

    func setImage(_ image: UIImage?) -> AlertBuilder {
        alertData.image = image
        return self
    }

    func setTitle(_ title: String?) -> AlertBuilder {
        alertData.title = title
        return self
    }

    func setSubText(_ subText: String?) -> AlertBuilder {
        alertData.subText = subText
        return self
    }

    func setSubTextColor(_ color: UIColor?) -> AlertBuilder {
        alertData.subTextColor = color
        return self
    }

    func setAction1(withTitle title: String?, action: (() -> Void)?) -> AlertBuilder {
        alertData.button1 = AlertButton(title: title, action: action)
        return self
    }

    func setAction2(withTitle title: String?, action: (() -> Void)?) -> AlertBuilder {
        alertData.button2 = AlertButton(title: title, action: action)
        return self
    }
}


final class AlertHelper {
    static func showAlert(in vc: UIViewController, withMessage message: String, withTitle title: String = "Thông báo", actionTitle: String = "Đóng", action: ((UIAlertAction) -> Void)? = nil ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: action))
        vc.present(alert, animated: true, completion: nil)
    }

    static func showAlertWithTwoOptions(in vc: UIViewController, withMessage message: String, withTitle title: String = "Thông báo", acceptActionTitle: String = "Đồng ý", cancelActionTitle: String = "Huỷ", acceptAction: ((UIAlertAction) -> Void)? = nil,  cancelAction: ((UIAlertAction) -> Void)? = nil ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: acceptActionTitle, style: UIAlertAction.Style.default, handler: acceptAction))
        alert.addAction(UIAlertAction(title: cancelActionTitle, style: UIAlertAction.Style.cancel, handler: cancelAction))

        vc.present(alert, animated: true, completion: nil)
    }
}
