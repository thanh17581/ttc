//
//  HomeVM.swift
//  TTCEasy
//
//  Created by TrungNV on 6/5/20.
//  Copyright © 2020 TTC Solutions VietNam. All rights reserved.
//

import Foundation
import RxCocoa
import Moya

enum DateState {
    case Empty
    case Normal
    case Late
    case DayOff
    case Current
}

struct CustomDate {
    var Date: Int?
    var Month: Int?
    var Year: Int?
    var state: DateState = .Normal
    var subText: String = ""
    var isDayOff: Bool = false
}

// 7 collumn, 6 rows
// Height of row = 50
class HomeVM: BaseVM {
    let heightOfNormalCell: CGFloat = 40.0
    let heightOfExpandedCell: CGFloat = 80.0
    let heightOfNormalCollection: CGFloat = 240.0
    let heightOfExpandedCollection: CGFloat = 480.0
    let numOfRows: Int = 6

    var listMonth: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    var currentMonth = BehaviorRelay<Int>(value: Date().getMonth())
    var currentYear = BehaviorRelay<Int>(value: Date().getYear())
    let currentDay = Date().getDay()
    var listCustomDates = BehaviorRelay<[CustomDate]>(value: [])

    var isExpanded = false

    func changeListDates(withMonth month: Int, year: Int) {
        let numOfDaysInMonth = DateHelpers.getNumberOfDays(inMonth: month, year: year)
        let firstDay = DateHelpers.getFirstDay(ofMonth: month, year: year) ?? 2
        let preList = [CustomDate](repeating: CustomDate(state: .Empty), count: firstDay == 1 ? 6 : firstDay - 2)
        var mainList = [CustomDate]()
        for i in 0..<numOfDaysInMonth {
            var state: DateState = .Normal
            if i + 1 == currentDay && currentMonth.value == Date().getMonth() && currentYear.value == Date().getYear(){
                state = .Current
            }
            let customDate = CustomDate(Date: i + 1, Month: month, Year: year, state: state, subText: "08:30 - 17:30")
            mainList.append(customDate)
        }
        listCustomDates.accept(preList + mainList)
    }

    func countOfListDate() -> Int {
        return listCustomDates.value.count
    }

    func dateAtIndex(_ index: Int) -> CustomDate{
        return listCustomDates.value[index]
    }
}
