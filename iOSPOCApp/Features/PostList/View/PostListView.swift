//
//  PostListView.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

import SwiftUI

struct PostListView: View {

    // MARK: - StateObject
    @StateObject private var viewModel: PostListViewModel

    init(viewModel: PostListViewModel = PostListViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading posts...")
                } else if let error = viewModel.error {
                    VStack(spacing: 12) {
                        Text(error)
                            .foregroundColor(.red)
                        Button("Retry") {
                            Task { await viewModel.fetchPosts() }
                        }
                    }
                } else {
                    List(viewModel.posts) { post in
                        postRowView(post: post)
                               .background(
                                   NavigationLink(value: post) {
                                       EmptyView()
                                   }
                                   .opacity(0.0)
                               )
                               .listRowSeparator(.hidden) // Removes default separator line interference
                               .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    }
                    .listStyle(.plain)
                }
            }
            .background(Color.mainBackgroundColor.ignoresSafeArea())
            .navigationTitle("Articles")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.brown, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationDestination(for: Post.self) { post in
                PostDetailView(post: post)
            }
            .task {
                if viewModel.posts.isEmpty {
                    await viewModel.fetchPosts()
                }
            }
        }
    }
}

extension PostListView {

    @ViewBuilder
    func postRowView(post: Post) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {

                HStack {
                    Text(post.status.uppercased())
                        .font(.caption2)
                        .bold()
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(
                            post.status == AppConstants.trending
                                ? Color.orange.opacity(0.2)
                                : Color.blue.opacity(0.2)
                        )
                        .foregroundColor(
                            post.status == AppConstants.trending
                                ? .orange
                                : .blue
                        )
                        .cornerRadius(4)

                    Spacer()

                    Text(post.dateString)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }

                Text(post.title)
                    .font(.headline)
                    .lineLimit(1)

                Text(post.shortDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 20, trailing: 16))
        .background(
            RoundedRectangle(cornerRadius: 12.0)
                .style(
                    withStroke: Color.tertiaryBackgroundColor,
                    lineWidth: 1,
                    fill: Color.secondaryBackgroundColor
                )
        )
        .contentShape(Rectangle())
    }
}
