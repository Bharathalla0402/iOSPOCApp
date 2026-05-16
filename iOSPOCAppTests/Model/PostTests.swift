//
//  PostTests.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 16/05/26.
//

import XCTest
@testable import iOSPOCApp

final class PostTests: XCTestCase {

    // MARK: - Helper
    func makePost(
        body: String,
        likes: Int
    ) -> Post {
        return Post(
            id: 1,
            title: "Test Title",
            body: body,
            views: 10,
            tags: ["swift", "ios"],
            reactions: Post.Reaction(likes: likes, dislikes: 2)
        )
    }

    // MARK: - shortDescription Tests

    func testShortDescription_withSentence_returnsFirstSentence() {
        let post = makePost(body: "Hello world. This is second sentence.", likes: 50)

        XCTAssertEqual(post.shortDescription, "Hello world.")
    }

    func testShortDescription_withoutPeriod_returnsFullBody() {
        let post = makePost(body: "Hello world without dot", likes: 50)

        XCTAssertEqual(post.shortDescription, "Hello world without dot.")
    }

    func testShortDescription_emptyBody_returnsEmpty() {
        let post = makePost(body: "", likes: 50)

        XCTAssertEqual(post.shortDescription, ".")
    }

    // MARK: - status Tests

    func testStatus_whenLikesGreaterThan100_returnsTrending() {
        let post = makePost(body: "Test", likes: 150)

        XCTAssertEqual(post.status, "Trending")
    }

    func testStatus_whenLikesEqual100_returnsFeatured() {
        let post = makePost(body: "Test", likes: 100)

        XCTAssertEqual(post.status, "Featured")
    }

    func testStatus_whenLikesLessThan100_returnsFeatured() {
        let post = makePost(body: "Test", likes: 50)

        XCTAssertEqual(post.status, "Featured")
    }

    // MARK: - dateString Tests

    func testDateString_returnsExpectedValue() {
        let post = makePost(body: "Test", likes: 10)

        XCTAssertEqual(post.dateString, "May 15, 2026")
    }

    // MARK: - Reaction Tests

    func testReaction_valuesStoredCorrectly() {
        let reaction = Post.Reaction(likes: 10, dislikes: 5)

        XCTAssertEqual(reaction.likes, 10)
        XCTAssertEqual(reaction.dislikes, 5)
    }

    // MARK: - Hashable / Identifiable

    @MainActor
    func testPostHashable() {
        let post1 = makePost(body: "Test", likes: 10)
        let post2 = makePost(body: "Test", likes: 10)

        XCTAssertEqual(post1, post2)
    }

    func testPostIdentifiable() {
        let post = makePost(body: "Test", likes: 10)

        XCTAssertEqual(post.id, 1)
    }
}
