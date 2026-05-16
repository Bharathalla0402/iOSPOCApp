//
//  APIService.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

import Foundation

protocol APIServiceProtocol {
    func fetchPosts() async throws -> [Post]
}

class APIService: APIServiceProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchPosts() async throws -> [Post] {
        guard !JailbreakDetector.isJailbroken() else {
            throw NetworkError.securityCompromised
        }

        guard let url = URL(string: Constants.API.postsURL) else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        do {
            let container = try JSONDecoder().decode(PostResponse.self, from: data)
            return container.posts
        } catch {
            throw NetworkError.decodingError
        }
    }
}
