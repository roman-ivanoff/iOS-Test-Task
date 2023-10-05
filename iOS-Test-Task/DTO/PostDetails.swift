//
//  PostDetails.swift
//  iOS-Test-Task
//
//  Created by Roman Ivanov on 05.10.2023.
//

import Foundation

struct PostDetails: Codable {
    let id: Int
    let timeshamp: UInt64
    let title: String
    let text: String
    let postImage: String
    let likesCount: Int

    enum CodingKeys: String, CodingKey {
        case id = "postId"
        case timeshamp
        case title
        case text
        case postImage
        case likesCount = "likes_count"
    }
}
