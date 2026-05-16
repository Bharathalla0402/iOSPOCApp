//
//  MockData.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 16/05/26.
//

import Foundation
@testable import iOSPOCApp

extension Post {
    static func mock(
        id: Int = 1,
        title: String = "Test Title",
        body: String = "This is test body. More text here.",
        views: Int = 10,
        tags: [String] = ["Tech"],
        likes: Int = 120,
        dislikes: Int = 5
    ) -> Post {
        Post(
            id: id,
            title: title,
            body: body,
            views: views,
            tags: tags,
            reactions: Reaction(likes: likes, dislikes: dislikes)
        )
    }
}

func makeViewModel() -> PostDetailViewModel {
    return PostDetailViewModel(post: makePost())
}

func makePost(
    tags: [String] = ["swift", "ios"],
    likes: Int = 120
) -> Post {
    return Post(
        id: 1,
        title: "Test Title",
        body: "First sentence. Second sentence.",
        views: 300,
        tags: tags,
        reactions: .init(likes: likes, dislikes: 5)
    )
}

struct PostDetailHelper {
    static func formattedTags(_ tags: [String]) -> String {
        tags.joined(separator: ", ")
    }
}

func makePost(body: String, likes: Int) -> Post {
    return Post(
        id: 1,
        title: "Test",
        body: body,
        views: 10,
        tags: ["tag"],
        reactions: .init(likes: likes, dislikes: 1)
    )
}
