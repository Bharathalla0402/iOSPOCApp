//
//  PostListViewModel.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

import SwiftUI
import Combine

@MainActor
class PostListViewModel: ObservableObject {
    // MARK: - Published Objects
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var error: String?
    @Published var showAlert: Bool = false

    // MARK: - iVars
    private let service: APIServiceProtocol

    init(
        service: APIServiceProtocol
    ) {
        self.service = service
    }

    func fetchPosts() async {
        isLoading = true
        defer { isLoading = false }
        error = nil
        showAlert = false

        do {
            posts = try await service.fetchPosts()
        } catch {
            posts = []
            self.error = AppConstants.failedData
            self.showAlert = true
        }
        isLoading = false
    }
}
