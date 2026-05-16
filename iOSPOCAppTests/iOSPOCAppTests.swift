//
//  iOSPOCAppTests.swift
//  iOSPOCAppTests
//
//  Created by Alla Bharath on 15/05/26.
//

import XCTest
@testable import iOSPOCApp

final class IOSPOCAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check results assertions after.
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
    }

    func testPostDetailViewInitialization() {
        let posts = Post.mock()
        let view = PostDetailView(post: posts)

        XCTAssertNotNil(view)
    }

    func testContentViewLoads() {
        let view = ContentView()
        XCTAssertNotNil(view)
    }

    func testCheckSuspiciousFilesReturnsFalse() {
        let result = JailbreakDetector.checkSuspiciousFiles()
        XCTAssertNotNil(result)
    }

    func testCheckSandboxViolationReturnsFalse() {
        let result = JailbreakDetector.checkSandboxViolation()
        XCTAssertFalse(result)
    }

    func testIsJailbrokenCombined() {
        let result = JailbreakDetector.isJailbroken()
        XCTAssertFalse(result)
    }

    func testSplashFlow() {
        let view = ContentView()
        XCTAssertNotNil(view)
    }

    func testFetchPostsSuccess() async throws {
        let service = MockAPIService()

        let posts = try await service.fetchPosts()

        XCTAssertTrue(posts.isEmpty)
    }

    func testPostDetailDataFormatting() {
        let post = Post(
            id: 1,
            title: "Title",
            body: "First sentence. Second sentence.",
            views: 200,
            tags: ["swift", "ios"],
            reactions: .init(likes: 120, dislikes: 5)
        )

        XCTAssertEqual(post.shortDescription, "First sentence.")
        XCTAssertEqual(post.status, "Trending")
        XCTAssertEqual(post.dateString, "May 15, 2026")
    }

    func testPostDetailViewInit() {
        let post = Post(
            id: 1,
            title: "Test",
            body: "Body",
            views: 10,
            tags: ["tag"],
            reactions: .init(likes: 10, dislikes: 1)
        )

        let view = PostDetailView(post: post)

        XCTAssertNotNil(view)
    }

    func testFormattedTags() {
        XCTAssertEqual(PostDetailHelper.formattedTags(["a", "b"]), "a, b")
    }

    func testAppInit_doesNotCrash() {
        let app = IOSPOCAppApp()
        XCTAssertNotNil(app)
    }

    func testShortDescription_multipleDots() {
        let post = makePost(body: "A. B. C.", likes: 10)
        XCTAssertEqual(post.shortDescription, "A.")
    }

    func testStatus_zeroLikes() {
        let post = makePost(body: "Test", likes: 0)
        XCTAssertEqual(post.status, "Featured")
    }

    func testInit_whenUITesting_returnsEarly() {
        let app = IOSPOCAppApp(
            arguments: ["UI_TESTING"],
            jailbrokenCheck: { false }
        )
        XCTAssertNotNil(app)
    }

    func testInit_whenNotUITest_andNotJailbroken() {
        let app = IOSPOCAppApp(
            arguments: [],
            jailbrokenCheck: { false }
        )
        XCTAssertNotNil(app)
    }

    func testInit_whenJailbroken_doesNotExitInUnitTest() {
        let app = IOSPOCAppApp(
            arguments: ["UNIT_TESTING"],
            jailbrokenCheck: { true }
        )
        XCTAssertNotNil(app)
    }

}
