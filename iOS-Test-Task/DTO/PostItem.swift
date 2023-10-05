//
//  PostItem.swift
//  iOS-Test-Task
//
//  Created by Roman Ivanov on 05.10.2023.
//

import Foundation

struct PostItem: Codable {
    let id: Int
    let timeshamp: UInt64
    let title: String
    let previewText: String
    let likesCount: Int


    enum CodingKeys: String, CodingKey {
        case id = "postId"
        case timeshamp
        case title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
}
