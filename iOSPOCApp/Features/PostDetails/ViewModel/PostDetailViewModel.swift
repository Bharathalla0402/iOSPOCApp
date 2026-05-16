//
//  PostDetailViewModel.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 16/05/26.
//

import Foundation

class PostDetailViewModel {

    private let post: Post

    init(post: Post) {
        self.post = post
    }

    // MARK: - Exposed Properties
    var title: String {
        post.title
    }

    var description: String {
        post.body
    }

    var tags: [String] {
        post.tags
    }

    var shortDescription: String {
        post.shortDescription
    }

    var tagsText: String {
        post.tags.joined(separator: ", ")
    }

    var likesText: Int {
        post.reactions.likes
    }

    var dislikesText: Int {
        post.reactions.dislikes
    }

    var status: String {
        post.status
    }

    var date: String {
        post.dateString
    }

    var isTrending: Bool {
        post.reactions.likes > 100
    }

    var hasTags: Bool {
        !post.tags.isEmpty
    }

    var postViews: Int {
        post.views
    }
}
