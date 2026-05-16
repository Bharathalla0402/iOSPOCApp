//
//  PostListViewModelTests.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

import XCTest
@testable import iOSPOCApp

final class PostListViewModelTests: XCTestCase {

    private var viewModel: PostListViewModel!
    private var mockService: MockAPIService!
    private var mockNetwork: MockNetworkMonitor!

    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
        mockNetwork = MockNetworkMonitor()
        viewModel = PostListViewModel(
            service: mockService,
            networkMonitor: mockNetwork
        )
    }

    override func tearDown() {
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
    @MainActor
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

    // Failure Case
    @MainActor
    func test_fetchPosts_failure() async {
        // Arrange
        mockService.shouldReturnError = true

        // Act
        await viewModel.fetchPosts()

        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.error, "Failed to load data")
        XCTAssertTrue(viewModel.posts.isEmpty)
    }

    // No Internet Case
    @MainActor
    func test_fetchPosts_noInternet() async {
        // Arrange
        mockNetwork.setConnection(false)

        // Act
        await viewModel.fetchPosts()

        // Assert
        XCTAssertEqual(viewModel.error, "No internet connection")
        XCTAssertTrue(viewModel.posts.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }

    // Internet Case
    @MainActor
    func test_fetchPosts_withInternet() async {
        // Arrange
        mockNetwork.setConnection(true)
        mockService.postsToReturn = [Post.mock()]

        // Act
        await viewModel.fetchPosts()

        // Assert
        XCTAssertEqual(viewModel.posts.count, 1)
        XCTAssertNil(viewModel.error)
    }

    // Reset Error Before Fetch
    @MainActor
    func test_fetchPosts_resetsError() async {
        // Arrange
        viewModel.error = "Old Error"
        mockService.postsToReturn = [Post.mock()]

        // Act
        await viewModel.fetchPosts()

        // Assert
        XCTAssertNil(viewModel.error)
    }

    // Empty Response
    @MainActor
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
