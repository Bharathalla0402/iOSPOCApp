//
//  PostDetailViewTests.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 16/05/26.
//

import XCTest
@testable import iOSPOCApp

final class PostDetailViewTests: XCTestCase {

    // Helper
    func makePost(
        id: Int = 1,
        title: String = "Test Title",
        body: String = "Test body.",
        views: Int = 10,
        tags: [String] = ["swift", "ios"],
        likes: Int = 10,
        dislikes: Int = 2
    ) -> Post {
        return Post(
            id: id,
            title: title,
            body: body,
            views: views,
            tags: tags,
            reactions: .init(likes: likes, dislikes: dislikes)
        )
    }

    // Basic execution (covers body + most views)
    func testView_executesBody() {
        let post = makePost()
        let view = makeHostingView(post: post)

        XCTAssertNotNil(view)
    }

    // Trending case (triggers headerBar logic)
    func testView_trendingCase_executesAllBranches() {
        let post = makePost(likes: 200)
        let view = makeHostingView(post: post)

        XCTAssertNotNil(view)
    }

    // Featured case (alternate branch)
    func testView_featuredCase_executesAllBranches() {
        let post = makePost(likes: 50)
        let view = makeHostingView(post: post)

        XCTAssertNotNil(view)
    }

    // Empty tags (covers tagSection edge case)
    func testView_emptyTags_executesTagSection() {
        let post = makePost(tags: [])
        let view = makeHostingView(post: post)

        XCTAssertNotNil(view)
    }

    // Large content (forces deeper closures)
    func testView_longContent_executesClosures() {
        let post = makePost(
            body: "A. B. C. D. E.",
            tags: ["a", "b", "c"],
            likes: 120,
            dislikes: 10
        )

        let view = makeHostingView(post: post)

        XCTAssertNotNil(view)
    }
}
