//
//  PostListViewModelTests.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

import XCTest
@testable import iOSPOCApp

@MainActor
final class PostListViewModelTests: XCTestCase {

    private var viewModel: PostListViewModel!
    private var mockService: MockAPIService!
    private var mockNetwork: MockNetworkMonitor!

    override func setUp() {
        super.setUp()
        MockURLProtocol.isEnabled = false
        mockService = MockAPIService()
        mockNetwork = MockNetworkMonitor()
        viewModel = PostListViewModel(
            service: mockService
        )
    }

    override func tearDown() {
        MockURLProtocol.isEnabled = false
        MockURLProtocol.mockData = nil
        MockURLProtocol.response = nil
        MockURLProtocol.error = nil
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
}

extension PostListViewModelTests {

    // Initial State
    func test_initialState() {
        XCTAssertTrue(viewModel.posts.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
    }

    // Success Case
    func test_fetchPosts_success() async {
        // Arrange
        let posts = [Post.mock()]
        mockService.postsToReturn = posts

        // Act
        await viewModel.fetchPosts()

        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
        XCTAssertEqual(viewModel.posts.count, 1)
        XCTAssertEqual(viewModel.posts.first?.title, "Test Title")
    }

    // Empty Response
    func test_fetchPosts_emptyResponse() async {
        // Arrange
        mockService.postsToReturn = []

        // Act
        await viewModel.fetchPosts()

        // Assert
        XCTAssertTrue(viewModel.posts.isEmpty)
        XCTAssertNil(viewModel.error)
    }

    // short description
    func test_post_shortDescription() {
        let post = Post.mock(body: "First sentence. Second sentence")

        XCTAssertEqual(post.shortDescription, "First sentence.")
    }

    // status trending
    func test_post_status_trending() {
        let post = Post.mock(likes: 150)

        XCTAssertEqual(post.status, "Trending")
    }

    // status featured
    func test_post_status_featured() {
        let post = Post.mock(likes: 50)

        XCTAssertEqual(post.status, "Featured")
    }

    // date string
    func test_post_dateString() {
        let post = Post.mock()

        XCTAssertEqual(post.dateString, "May 15, 2026")
    }
}
