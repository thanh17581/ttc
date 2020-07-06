//
//  AuthService.swift
//  Tecomen
//
//  Created by TrungNV on 4/4/20.
//  Copyright © 2020 ttc-solutions. All rights reserved.
//

import Foundation
import Moya

enum AuthService {
    case login(params: [String: String])
}

extension AuthService: TargetType{
    var path: String {
        switch self {
        case .login:
            return "/account/login"
        }
    }

    var task: Task {
        switch self {
        case  let .login(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
}
