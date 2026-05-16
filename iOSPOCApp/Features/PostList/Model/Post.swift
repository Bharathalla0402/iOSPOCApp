//
//  Post.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

import Foundation

struct PostResponse: Decodable {
    let posts: [Post]
}

struct Post: Identifiable, Hashable, Decodable {
    let id: Int
    let title: String
    let body: String
    let views: Int
    let tags: [String]
    let reactions: Reaction

    struct Reaction: Hashable, Decodable {
        let likes: Int
        let dislikes: Int
    }

    // Derived UI Fields
    var shortDescription: String {
        return body.components(separatedBy: ".").first?.appending(".") ?? body
    }

    var status: String {
        return reactions.likes > 100 ? "Trending" : "Featured"
    }

    var dateString: String {
        return "May 15, 2026"
    }
}
