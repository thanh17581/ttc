//
//  DateExtension.swift
//  TTCFaceID
//
//  Created by TrungNV on 3/12/20.
//  Copyright © 2020 ttc-solutions. All rights reserved.
//

import UIKit

extension Date {
    func setTime(from: Date = Date(), hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date? {
        let gregorian = Calendar(identifier: .gregorian)
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: from)
        components.hour = hour
        components.minute = minute
        components.second = second

        let date = gregorian.date(from: components)
        return date
    }

    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func toDateString(format: String = "dd/MM/yyyy", timeZone: String = "UTC+00:00") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let tz = TimeZone(abbreviation: timeZone) {
            formatter.timeZone = tz
        }
        return formatter.string(from: self)
    }

    func getCurrentMillis()->Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }

    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }

    func byAdding(_ day: Int) -> Date {
        return Calendar.current.date(byAdding: DateComponents(day: day), to: self) ?? self
    }
    func getCurrenHourly() -> Int {
        return Calendar.current.component(.hour, from: Date())
    }

    func getYear() -> Int {
        return Int(self.toDateString(format: "yyyy")) ?? 0
    }

    func getMonth() -> Int {
        return Int(self.toDateString(format: "MM")) ?? 0
    }

    func getDay() -> Int {
        return Int(self.toDateString(format: "dd")) ?? 0
    }

    func getHour() -> Int {
        return Int(self.toDateString(format: "HH")) ?? 0
    }

    func getMinute() -> Int {
        return Int(self.toDateString(format: "mm")) ?? 0
    }
    func isBetween(date date1: Date, andDate date2: Date) -> Bool {
        return date1.compare(self) == self.compare(date2)
    }
}

class DateHelpers {
    static func getNumberOfDays(inMonth month: Int, year: Int) -> Int{
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }

//    static func startDate(ofMonth month: Int, year: Int) -> Date {
//        let calendar: Calendar = Calendar.current
//        let strMonth = month >= 10 ? "\(month)" : "0\(month)"
//        let startDate = calendar.startOfMonth("01/" + strMonth + "/\(year)".toDate() ?? Date())
//    }

    static func getDayOfWeek(_ day:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        guard let todayDate = formatter.date(from: day) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }

    static func getFirstDay(ofMonth month: Int, year: Int) -> Int? {
        let strMonth = month >= 10 ? "\(month)" : "0\(month)"
        let fullDateStr = "01/" + strMonth + "/\(year)"
        return getDayOfWeek(fullDateStr)
    }

//    static func startDay(inMonth month: Int, year: Int) -> Int {
//
//    }
//
//    static func endDay(inMonth month: Int, year: Int) -> Int {
//
//    }
}

