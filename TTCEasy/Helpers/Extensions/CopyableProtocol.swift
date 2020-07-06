//
//  CopyableProtocol.swift
//  TTCFaceID
//
//  Created by TrungNV on 3/10/20.
//  Copyright © 2020 ttc-solutions. All rights reserved.
//

import Foundation

protocol Copyable {
    init(instance: Self)
}

extension Copyable {
    func copy() -> Self {
        return Self.init(instance: self)
    }
}
