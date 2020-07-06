//
//  BaseModel.swift
//  TTCEasy
//
//  Created by TrungNV on 6/3/20.
//  Copyright © 2020 TTC Solutions VietNam. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseModel: Mappable {
    var error_code: Int?
    var message: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        error_code <- map["error_code"]
        message <- map["message"]
    }
}
