//
//  ServiceError.swift
//  iOS-Test-Task
//
//  Created by Roman Ivanov on 05.10.2023.
//

import Foundation

enum ServiceError: Error, LocalizedError, Equatable {
    case invalidUrl
    case invalidResponseStatus
    case dataTaskError(String)
    case corruptData
    case decodingError(String)
    case invalidParameters
}
