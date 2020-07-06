//
//  TAlertView.swift
//  Heya
//
//  Created by TrungNV on 10/14/19.
//  Copyright © 2019 TrungNV. All rights reserved.
//

import UIKit

class TAlertView: UIView {
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backgroundView: UIVisualEffectView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var viewImage: UIView!

    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMainText: UILabel!
    
    var didAccept: (() -> Void)?
    var didCancel: (() -> Void)?
    
    init(title: String? = nil, msg: String, msgColor: UIColor? = nil, image: UIImage? = nil, button1: AlertButton? = nil, button2: AlertButton? = nil){
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        commonInit()

        if let alertTitle = title{
            lblTitle.text = alertTitle.trimed
        }else{
            lblTitle.text = "Thông báo"
        }
        if let img = image {
            viewImage.isHidden = false
            self.image.image = img
        }else{
            viewImage.isHidden = true
        }

        lblMainText.text = msg.trimed
        if let msgCo = msgColor {
            lblMainText.textColor = msgCo
        }

        if let btn2 = button2 {
            btnCancel.isHidden = false
            btnCancel.setTitle(btn2.title ?? " ", for: .normal)
        }else{
            btnCancel.isHidden = true
        }
        btnAccept.setTitle(button1?.title ?? "Đóng", for: .normal)
        didAccept = button1?.action
        didCancel = button2?.action
        
        initUI()
    }
    
    public func show() {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while (topController?.presentedViewController != nil) {
            topController = topController?.presentedViewController
        }
        topController?.view.addSubview(self)
        showView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        initUI()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("TAlertView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func initUI(){
        alertView.cornerRadius = 20
        btnAccept.cornerRadius = 15
        btnCancel.cornerRadius = 15
        btnCancel.borderColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        btnCancel.borderWidth = 1.5
        btnCancel.setTitleColor(#colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1), for: .normal)
        btnAccept.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btnAccept.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        alertView.alpha = 0.01
    }
    
    // MARK: - Functions
    private func showView(){
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseIn], animations: {
            self.backgroundView.alpha = 0.4
            self.alertView.transform = CGAffineTransform(translationX: 0.0, y: 60.0)
            self.alertView.alpha = 1
        }, completion: nil)
    }
    
    private func hideView() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseOut], animations: {
            self.backgroundView.alpha = 0.01
            self.alertView.transform = CGAffineTransform.identity
            self.alertView.alpha = 0.01
        }){  finish in
            self.removeFromSuperview()
        }
    }
    
    // MARK: - Actions
    @IBAction func acceptAction(_ sender: Any) {
        if let accept = didAccept{
            accept()
        }
        hideView()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        if let cancel = didCancel{
            cancel()
        }
        hideView()
    }
    
}
