//
//  Date+String.swift
//  teamwork-tech-test
//
//  Created by Denis Quaid on 03/08/2017.
//  Copyright © 2017 Denis Quaid. All rights reserved.
//

import Foundation

extension Date {
    func shortFormatForDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }
}

extension String {
    func formattedDateString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        return dateFormatter.date(from: self)?.shortFormatForDate()
    }
}
