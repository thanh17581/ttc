//
//  ConstraintExtension.swift
//  TTCEasy
//
//  Created by TrungNV on 6/5/20.
//  Copyright © 2020 TTC Solutions VietNam. All rights reserved.
//

import Foundation
import RxSwift

extension NSLayoutConstraint{
    var rx_constraint: Observable<CGFloat?>{
        return self.rx.observe(CGFloat.self, "constant")
    }
}
