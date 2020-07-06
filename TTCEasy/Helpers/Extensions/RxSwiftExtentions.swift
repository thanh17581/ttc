//
//  RxSwiftExtentions.swift
//  TTCFaceID
//
//  Created by TrungNV on 3/11/20.
//  Copyright © 2020 ttc-solutions. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

infix operator <->
@discardableResult func <-><T>(property: ControlProperty<T>, variable: BehaviorRelay<T>) -> Disposable {
    let variableToProperty = variable.asObservable()
        .bind(to: property)

    let propertyToVariable = property
        .subscribe(
            onNext: { variable.accept($0) },
            onCompleted: { variableToProperty.dispose() }
    )

    return Disposables.create(variableToProperty, propertyToVariable)
}

