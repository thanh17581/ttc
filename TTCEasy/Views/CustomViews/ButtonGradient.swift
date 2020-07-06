//
//  ButtonGradient.swift
//  mBCCSiOS
//
//  Created by Macbook on 4/25/19.
//  Copyright © 2019 ttc. All rights reserved.
//

import UIKit

@IBDesignable class ButtonGradient: UIButton {
    let gradient = CAGradientLayer()
    
    @IBInspectable var isGradientBorder: Bool = false {
        didSet {
            setupView()
        }
    }

    override var isEnabled: Bool {
        didSet {
            setupView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Layout
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.frame.size)
        setupView()
    }
    
    private func setupView() {
        titleLabel?.textColor = UIColor.white
        layer.masksToBounds = true
        layer.cornerRadius = self.bounds.height / 2

        if isEnabled{
             gradient.colors = [Colors.leftColor.cgColor, Colors.rightColor.cgColor]
        }else{
            gradient.colors = [Colors.leftColor.cgColor, Colors.rightColor.cgColor]
        }

        gradient.frame = bounds
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        self.layer.insertSublayer(gradient, at: 0)
        if isGradientBorder {
            titleLabel?.textColor = Colors.leftColor
            titleLabel?.font = UIFont.init(name: "Roboto-Light", size: 14)!
            let shape = CAShapeLayer()
            shape.lineWidth = 1.5
            shape.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
            shape.strokeColor = UIColor.black.cgColor
            shape.fillColor = UIColor.clear.cgColor
            gradient.mask = shape
        }
    }
}

