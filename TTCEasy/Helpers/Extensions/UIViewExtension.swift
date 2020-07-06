//
//  UIViewExtension.swift
//  TTCFaceID
//
//  Created by TrungNV on 3/10/20.
//  Copyright © 2020 ttc-solutions. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
           get {
               return layer.borderWidth
           }
           set {
               layer.borderWidth = newValue
           }
       }

    @IBInspectable var borderColor: UIColor {
           get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.white.cgColor)
           }
           set {
            layer.borderColor = newValue.cgColor
           }
       }

    func createShadow(scale: Bool = true, color shadowColor: UIColor = Colors.shadowColor) {
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 4
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

