//
//  LoginVM.swift
//  TTCEasy
//
//  Created by TrungNV on 6/3/20.
//  Copyright © 2020 TTC Solutions VietNam. All rights reserved.
//

import Foundation
import RxCocoa
import Moya

final class LoginVM: BaseVM {
    var user = BehaviorRelay<UserModel?>(value: nil)

    func checkUserName(_ username: String?) -> (Bool, String){
        guard let user = username, !user.trimed.isEmpty else {
            return (false, "Tên đăng nhập không được để trống.")
        }
        if user.count < 6 {
            return (false, "Tên đăng nhập phải có ít nhất 6 ký tự.")
        }
        if user.hasSpcialCharacter() {
            return (false, "Tên đăng nhập không được có ký tự đặc biệt.")
        }
        return (true,"")
    }

    func checkPass(_ password: String?) -> (Bool, String) {
        guard let pass = password, !pass.trimed.isEmpty else {
            return (false, "Mật khẩu không được để trống.")
        }
        return (true, "")
    }

    func login(inVC vc: BaseVC, username: String, password: String){
        var input: [String: String] = [:]
        input["username"] = username
        input["password"] = password
        AppUtils.hideLoading(inVC: vc, false)
        let target = MultiTarget(AuthService.login(params: input))

        Network.request(class: LoginModel.self, target: target, vc: vc, checkTokenExp: false, success: { [unowned self] obj in
            self.user.accept(obj.data?.user)
        })
    }
}
