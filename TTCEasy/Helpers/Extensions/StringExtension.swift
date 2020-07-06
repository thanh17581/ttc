//
//  StringExtension.swift
//  Tecomen
//
//  Created by TrungNV on 3/6/20.
//  Copyright © 2020 ttc-solutions. All rights reserved.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    var trimed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func removeDiacritics() -> String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }

    func toDate(format: String = "dd/MM/yyyy", timeZone: String = "UTC+00:00", locale: String = "") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if locale != ""{
            formatter.locale = Locale(identifier: locale)
        }
        if let tz = TimeZone(abbreviation: timeZone) {
            formatter.timeZone = tz
        }
        return formatter.date(from: self)
    }

    func toStringDate(fromDateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSS",
                      toDateFormat: String = "dd/MM/yyyy") -> String? {

        let initalFormatter = DateFormatter()
        initalFormatter.dateFormat = fromDateFormat

        guard let initialDate = initalFormatter.date(from: self) else {
            print ("Error in dateString or in fromDateFormat")
            return nil
        }

        let resultFormatter = DateFormatter()
        resultFormatter.dateFormat = toDateFormat

        return resultFormatter.string(from: initialDate)
    }

    func toDate(fromDateFormat: String = "dd/MM/yyyy") -> Date? {
        let initalFormatter = DateFormatter()
        initalFormatter.dateFormat = fromDateFormat

        guard let initialDate = initalFormatter.date(from: self) else {
            print ("Error in dateString or in fromDateFormat")
            return nil
        }
        return initialDate
    }

    func isDateFormat(_ format: String = "dd/MM/yyyy") -> Bool {
        if let _ = toDate(fromDateFormat: format) {
            return true
        }
        return false
    }

    func isDateMoreThanNow() -> Bool {
        let date = Date()
        let strNow = date.toString(dateFormat: "dd/MM/yyyy")
        let dateNow = strNow.toDate()
        let dateSelf = self.toDate()
        if let now = dateNow,  let dSelf = dateSelf {
            return dSelf > now
        }
        return true
    }

    func hasSpcialCharacter() -> Bool {
        for s in ["@", "*", "!", "@", "#", "$", "%", "^", "&", "<", ">", "'", "\"", "~", "`", "|", "?"] {
            if self.contains(s) {
                return true
            }
        }
        return false
    }
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}

// MARK: - Moya Helpers
extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

extension Optional where Wrapped == String {
    func value(_ defaultValue: String = "") -> String {
        return (self ?? defaultValue).trimed
    }
}
