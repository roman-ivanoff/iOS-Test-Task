//
//  Helper.swift
//  iOS-Test-Task
//
//  Created by Roman Ivanov on 05.10.2023.
//

import Foundation

class Helper {
    func getDateByTimestamp(timestamp: UInt64) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(timestamp))
    }

    func getPastDays(pastDate: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: pastDate, to: Date()).day ?? 0
    }
}
