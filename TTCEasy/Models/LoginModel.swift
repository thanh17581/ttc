//
//  LoginModel.swift
//  TTCEasy
//
//  Created by TrungNV on 6/3/20.
//  Copyright © 2020 TTC Solutions VietNam. All rights reserved.
//

import Foundation
import ObjectMapper

final class LoginModel: BaseModel {
    var data: LoginModelData?

    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}

final class LoginModelData: Mappable {
    var user: UserModel?
    var token: TokenModel?

    func mapping(map: Map) {
        user <- map["user"]
        token <- map["token"]
    }

    init?(map: Map) {}
}

final class UserModel: Mappable {
    var userId: Int?
    var userCode: String?
    var fName: String?
    var lName: String?
    var email: String?
    var phoneNo: String?
    var dob: String?
    var sex: String?
    var imageAvt: String?
    var imageCover: String?
    var ethnic: String?
    var relationship: Int?
    var nation: Int?
    var fbAccount: String?
    var skypeAccount: String?
    var taxIdNo: String?
    var roleId: Int?
    var statusId: Int?
    var depId: Int?
    var note: String?
    var tokenId: Int?
    var attendanceCode: String?
    var religion: Int?
    var curProvince: String?
    var curDistrict: String?
    var curPrecinct: String?
    var curStreet: String?
    var curHome: String?
    var curDetailAdd: String?
    var faculty: Int?
    var trainingPlace: String?
    var cultureLevel: String?
    var academicLevel: String?
    var createUser: String?
    var trainingMethodId: Int?
    var academicLevelId: Int?
    var accountId: Int?
    var username: String?
    var createDate: String?
    var updateDate: String?

    func mapping(map: Map) {
        userId <- map["userId"]
        userCode <- map["userCode"]
        fName <- map["fName"]
        lName <- map["lName"]
        email <- map["email"]
        phoneNo <- map["phoneNo"]
        dob <- map["dob"]
        sex <- map["sex"]
        imageAvt <- map["imageAvt"]
        imageCover <- map["imageCover"]
        ethnic <- map["ethnic"]
        relationship <- map["relationship"]
        nation <- map["nation"]
        fbAccount <- map["fbAccount"]
        skypeAccount <- map["skypeAccount"]
        taxIdNo <- map["taxIdNo"]
        roleId <- map["roleId"]
        statusId <- map["statusId"]
        depId <- map["depId"]
        note <- map["note"]
        tokenId <- map["tokenId"]
        attendanceCode <- map["attendanceCode"]
        religion <- map["religion"]
        curProvince <- map["curProvince"]
        curDistrict <- map["curDistrict"]
        curPrecinct <- map["curPrecinct"]
        curStreet <- map["curStreet"]
        curHome <- map["curHome"]
        curDetailAdd <- map["curDetailAdd"]
        faculty <- map["faculty"]
        trainingPlace <- map["trainingPlace"]
        cultureLevel <- map["cultureLevel"]
        academicLevel <- map["academicLevel"]
        createUser <- map["createUser"]
        trainingMethodId <- map["trainingMethodId"]
        academicLevelId <- map["academicLevelId"]
        accountId <- map["accountId"]
        username <- map["username"]
        createDate <- map["createDate"]
        updateDate <- map["updateDate"]
    }

    init?(map: Map) {}
}

final class TokenModel: Mappable {
    var tokenId: Int?
    var tokenValue: String?
    var userId: Int?
    var statusId: Int?
    var email: String?
    var createDate: String?
    var expireDate: String?

    func mapping(map: Map) {
        tokenId <- map["tokenId"]
        tokenValue <- map["tokenValue"]
        userId <- map["userId"]
        statusId <- map["statusId"]
        email <- map["email"]
        createDate <- map["createDate"]
        expireDate <- map["expireDate"]
    }

    init?(map: Map) {}
}
