//
//  QueryBuilder.swift
//  iOS-Test-Task
//
//  Created by Roman Ivanov on 05.10.2023.
//

import Foundation

class QueryBuilder {
    func getAllPostsUrl() -> URL? {
        URL(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json")
    }
    
    func getPostByIdUrl(id: String) -> URL? {
        URL(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/\(id).json")
    }
}
