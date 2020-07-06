//
//  DAOHelper.swift
//  Tecomen
//
//  Created by TrungNV on 3/5/20.
//  Copyright © 2020 ttc-solutions. All rights reserved.
//

import Foundation
import YapDatabase

final class DAOHelper {
    static func getInstance() -> DAOHelper{
        let dao = DAOHelper()
        dao.db = YapDatabase()
        dao.connection = dao.db.newConnection()
        return dao
    }
    var db: YapDatabase!
    var connection: YapDatabaseConnection!

    func register<T: Codable>(_ type: T.Type){
        db.registerCodableSerialization(T.self, forCollection: YapCollections.userInfo)
    }

    func setObject<T: Codable>(forKey key: String, withType type: T.Type, data: T, completion: (() -> Void)? = nil){
        db.registerCodableSerialization(T.self, forCollection: YapCollections.userInfo)
        connection.asyncReadWrite({ (transaction) in
            transaction.setObject(data, forKey: key, inCollection: YapCollections.userInfo)
            if let complete = completion{
                complete()
            }
        })
    }

    func asyncSetObject<T: Codable>(forKey key: String, withType type: T.Type, data: T, completion: (() -> Void)? = nil){
        db.registerCodableSerialization(T.self, forCollection: YapCollections.userInfo)
        connection.asyncReadWrite({ (transaction) in
            transaction.setObject(data, forKey: key, inCollection: YapCollections.userInfo)
        }) {
            if let complete = completion{
                complete()
            }
        }
    }

    func getObject<T: Codable>(fromKey key: String, withType type: T.Type, completion: ((_ data: T?) -> ())?) {
        db.registerCodableSerialization(T.self, forCollection: YapCollections.userInfo)
        connection.read {(transaction) in
            let obj: T? = transaction.object(forKey: key, inCollection: YapCollections.userInfo) as? T
            if let complete = completion{
                complete(obj)
            }
        }
    }

    func asyncGetObject<T: Codable>(fromKey key: String, withType type: T.Type, completion: ((_ data: T?) -> ())?) {
        db.registerCodableSerialization(T.self, forCollection: YapCollections.userInfo)
        connection.asyncRead { (transaction) in
            let obj: T? = transaction.object(forKey: key, inCollection: YapCollections.userInfo) as? T
            DispatchQueue.main.async {
                if let complete = completion{
                    complete(obj)
                }
            }
        }
    }
}
