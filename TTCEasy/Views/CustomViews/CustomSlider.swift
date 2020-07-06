//
//  CustomSlider.swift
//  Tecomen
//
//  Created by TrungNV on 4/23/20.
//  Copyright © 2020 ttc-solutions. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {
    @IBInspectable var trackHeight: CGFloat = 7

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newRect = super.trackRect(forBounds: bounds)
        newRect.size.height = trackHeight
        return newRect
    }
}
