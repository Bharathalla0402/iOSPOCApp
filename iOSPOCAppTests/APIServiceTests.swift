//
//  APIServiceTests.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 16/05/26.
//

import XCTest
@testable import iOSPOCApp

final class APIServiceTests: XCTestCase {

    var service: APIService!

    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        service = APIService(session: session)
    }
}

extension APIServiceTests {
    @MainActor
    func testFetchPostsSuccess() async throws {
        let json = """
        {
            "posts": [
                {
                    "id": 1,
                    "title": "Test Title",
                    "body": "Test body description.",
                    "views": 120,
                    "tags": ["ios", "swift"],
                    "reactions": {
                        "likes": 150,
                        "dislikes": 10
                    }
                }
            ]
        }
        """

        MockURLProtocol.mockData = json.data(using: .utf8)
        MockURLProtocol.response = HTTPURLResponse(
            url: URL(string: Constants.API.postsURL)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let posts = try await service.fetchPosts()

        XCTAssertEqual(posts.count, 1)
        XCTAssertEqual(posts.first?.id, 1)
        XCTAssertEqual(posts.first?.title, "Test Title")
        XCTAssertEqual(posts.first?.views, 120)
        XCTAssertEqual(posts.first?.reactions.likes, 150)
    }

    @MainActor
    func testFetchPostsDecodingError() async {
        let invalidJSON = """
        {
            "posts": [
                {
                    "wrong_key": 1
                }
            ]
        }
        """

        MockURLProtocol.mockData = invalidJSON.data(using: .utf8)
        MockURLProtocol.response = HTTPURLResponse(
            url: URL(string: Constants.API.postsURL)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        do {
            _ = try await service.fetchPosts()
            XCTFail("Expected decoding error")
        } catch {
            XCTAssertEqual(error as? NetworkError, .decodingError)
        }
    }

    @MainActor
    func testFetchPostsInvalidResponse() async {
        MockURLProtocol.mockData = Data()
        MockURLProtocol.response = HTTPURLResponse(
            url: URL(string: Constants.API.postsURL)!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )

        do {
            _ = try await service.fetchPosts()
            XCTFail("Expected invalidResponse error")
        } catch {
            XCTAssertEqual(error as? NetworkError, .invalidResponse)
        }
    }

}
