//
//  Date+Configuration.swift
//  iOS-Test-Task
//
//  Created by Roman Ivanov on 05.10.2023.
//

import Foundation

extension Date {
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
}
