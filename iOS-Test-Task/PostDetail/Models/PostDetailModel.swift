//
//  PostDetailModel.swift
//  iOS-Test-Task
//
//  Created by Roman Ivanov on 05.10.2023.
//

import Foundation

class PostDetailModel {
    var postId: Int = 0
    let service = PostService()
    var postDetails: PostDetails? = nil
    let queryBuilder = QueryBuilder()
    var isLoading = false
    
    func fetchPostDetails(
        onSuccess: @escaping(PostDetailsResponse) -> Void,
        onError: @escaping(ServiceError) -> Void
    ) {
        isLoading = true
        service.fetchPosts(url: queryBuilder.getPostByIdUrl(id: String(postId))) { [weak self] (result: Result<PostDetailsResponse, ServiceError>) in
            guard let self else { return }
            
            switch result {
            case let .success(data):
                isLoading = false
                postDetails = data.post
                onSuccess(data)
            case let .failure(error):
                isLoading = false
                onError(error)
            }
        }
    }
}
