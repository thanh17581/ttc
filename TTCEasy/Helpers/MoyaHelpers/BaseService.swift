//
//  BaseService.swift
//  MoyaGitHub
//
//  Created by TrungNV on 2/3/20.
//  Copyright © 2020 trungnv. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Alamofire

public extension TargetType {
    var baseURL: URL {
        return URL(string: URLs.devBaseURL)!
    }

    var method: Moya.Method {
        return .post
    }

    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        let header = ["Content-type": "application/json"]
        return header
    }
}


