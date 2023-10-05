//
//  PostListModel.swift
//  iOS-Test-Task
//
//  Created by Roman Ivanov on 05.10.2023.
//

import Foundation

class PostListModel {
    let service = PostService()
    let queryBuilder = QueryBuilder()
    var isLoading = false
    var posts: [PostItem] = []
    
    func fetchPosts(
        onSuccess: @escaping(PostListResponse) -> Void,
        onError: @escaping(ServiceError) -> Void
    ) {
        isLoading = true
        service.fetchPosts(url: queryBuilder.getAllPostsUrl()) { [weak self] (result: Result<PostListResponse, ServiceError>) in
            guard let self else { return }
            
            switch result {
            case let .success(data):
                self.posts = data.posts
                self.isLoading = false
                onSuccess(data)
            case let .failure(error):
                self.isLoading = false
                onError(error)
            }
        }
    }
}
