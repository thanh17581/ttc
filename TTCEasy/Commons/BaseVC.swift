//
//  BaseVC.swift
//  MoyaGitHub
//
//  Created by TrungNV on 2/3/20.
//  Copyright © 2020 trungnv. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MBProgressHUD
import Toast_Swift

class BaseVC: UIViewController{

    let gradientLayer = CAGradientLayer()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
        bindData()
        setupNotifications()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "ic_back_white")
        navigationController?.navigationBar.tintColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 15.0)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]

        gradientLayer.frame = self.view.bounds
        navigationController?.makeTransparent()
//        setupGradientBackground()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = self.view.bounds
    }
    
    func bindData() {}
    func initUI() {
//        setupGradientBackground()
        
        
    }
    func initData() {}
    func bindUI() {}

    func setupNotifications() {
        NotificationCenter.default
        .addObserver(self,
                     selector: #selector(hideLoading(_:)),
                     name: NSNotification.Name (NotificationKeys.loading), object: nil)

        NotificationCenter.default
        .addObserver(self,
                     selector: #selector(showMsg(_:)),
                     name: NSNotification.Name (NotificationKeys.showMsg), object: nil)
    }

    @objc func hideLoading(_ notification: Notification){
        if let isHidden = notification.userInfo?["isHidden"] as? Bool, let _ = notification.userInfo?["vc"] as? Self{
            if isHidden {
                MBProgressHUD.hide(for: self.view, animated: true)
            }else{
                MBProgressHUD.showAdded(to: self.view, animated: true)
            }

        }else{
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }

    @objc func showMsg(_ notification: Notification){
        if let msg = notification.userInfo?["msg"] as? String, let _ = notification.userInfo?["vc"] as? Self{
            self.view.makeToast(msg)
        }
    }

    func dismissOrPop() {
        if self.navigationController?.topViewController == self {
            self.navigationController?.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }

    func goBackHome() {
       
    }

    func showVC(formXibType type: BaseVC.Type) {
        let vc = NavigationHelper.createViewController(fromXIBType: type)
        if let nav = self.navigationController {
            nav.pushViewController(vc, animated: true)
        }else{
            self.present(vc, animated: true, completion: nil)
        }
    }

    func setupGradientBackground() {
        // Setup gradient background
        gradientLayer.colors = [Colors.leftColor.cgColor,
                                Colors.rightColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

}
