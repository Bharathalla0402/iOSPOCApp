//
//  PostListViewModel.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

import SwiftUI
import Combine

class PostListViewModel: ObservableObject {
    // MARK: - Published Objects
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var error: String? = nil
    @Published var showAlert: Bool = false

    // MARK: - iVars
    private let service: APIServiceProtocol
    private let networkMonitor: NetworkMonitor

    init(
        service: APIServiceProtocol = APIService(),
        networkMonitor: NetworkMonitor = NetworkMonitor()
    ) {
        self.service = service
        self.networkMonitor = networkMonitor
    }

    @MainActor
    func fetchPosts() async {
        isLoading = true
        error = nil
        do {
            posts = try await service.fetchPosts()
        } catch {
            self.error = AppConstants.failedData
            self.showAlert = true
        }
        isLoading = false
    }
}
