//
//  LoginVC.swift
//  TTCEasy
//
//  Created by TrungNV on 6/2/20.
//  Copyright © 2020 TTC Solutions VietNam. All rights reserved.
//

import UIKit

class LoginVC: BaseVC {

    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!

    let vm = LoginVM()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func bindData() {
        super.bindData()
        vm.user.filter{$0 != nil}.subscribe(onNext: { user in
            NavigationHelper.setRoot(withVC: HomeVC())
        }).disposed(by: disposeBag)
    }

    @IBAction func loginAction(_ sender: Any) {
        self.view.endEditing(true)
        let userName = tfUsername.text.value().trimed
        let pass = tfPassword.text.value().trimed
        let checkUsername = vm.checkUserName(userName)
        let checkPass = vm.checkPass(pass)
        let (isOk, msg) = AppUtils.checkValids([checkUsername, checkPass])
        if !isOk {
            self.view.makeToast(msg)
            return
        }

        vm.login(inVC: self, username: userName, password: pass)
    }

}
