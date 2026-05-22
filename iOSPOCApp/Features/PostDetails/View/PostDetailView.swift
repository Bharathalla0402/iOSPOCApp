//
//  PostDetailView.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

import SwiftUI

struct PostDetailView: View {

    // MARK: - Environment Objects
    @Environment(\.dismiss) private var dismiss

    // MARK: - iVars
    @StateObject private var viewModel: PostDetailViewModel

    // MARK: - Init (PRIMARY - for testing)
    init(viewModel: PostDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 0) {

            headerBar

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    headerView
                    titleView
                    tagSection

                    Divider()

                    descriptionView

                    Divider()

                    reactionFooter
                }
                .padding()
                .padding(.top, 8)
            }
            .background(Color.mainBackgroundColor.ignoresSafeArea())
        }
        .navigationBarHidden(true)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

// MARK: - Convenience Init (for app usage)
extension PostDetailView {
    init(post: Post) {
        self.init(viewModel: PostDetailViewModel(post: post))
    }
}

private extension PostDetailView {

    // MARK: - Header
    @ViewBuilder
    var headerBar: some View {
        ZStack {
            Color.brown.opacity(0.85)
                .ignoresSafeArea(edges: .top)

            HStack {
                Button(
                    action: {
                        dismiss()
                    },
                    label: {
                        Image(systemName: Constants.ImageStrings.leftImage)
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color.white.opacity(0.6))
                            .clipShape(Circle())
                    }
                )

                Spacer()

                Text(AppConstants.details)
                    .font(.headline)
                    .fontWeight(.semibold)

                Spacer()

                Image(systemName: Constants.ImageStrings.bookmark)
                    .font(.headline)
                    .hidden()
            }
            .padding(.horizontal)
            .padding(.top, 5)
        }
        .frame(height: 60)
    }

    // MARK: - Meta Header
    @ViewBuilder
    var headerView: some View {
        HStack(spacing: 10) {
            Text(viewModel.date)

            Text(AppConstants.dot)

            HStack(spacing: 4) {
                Image(systemName: Constants.ImageStrings.fillEye)
                Text("\(viewModel.postViews)")
            }

            Text(AppConstants.read)

            Spacer()
        }
        .font(.subheadline)
        .foregroundColor(.secondary)
    }

    // MARK: - Title
    @ViewBuilder
    var titleView: some View {
        Text(viewModel.title)
            .font(.system(size: 30, weight: .bold))
            .foregroundColor(.primary)
            .lineSpacing(4)
    }

    // MARK: - Tags Section
    @ViewBuilder
    var tagSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(viewModel.tags, id: \.self) { tag in
                    tagView(tag)
                }
            }
        }
    }

    @ViewBuilder
    func tagView(_ tag: String) -> some View {
        Text("#\(tag)")
            .font(.caption)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.orange.opacity(0.2))
            .foregroundColor(.orange)
            .clipShape(Capsule())
    }

    // MARK: - Description
    @ViewBuilder
    var descriptionView: some View {
        Text(viewModel.description)
            .font(.body)
            .foregroundColor(.primary)
            .lineSpacing(7)
    }

    // MARK: - Reactions
    @ViewBuilder
    var reactionFooter: some View {
        HStack {
            reactionItem(
                icon: Constants.ImageStrings.handUpFill,
                value: viewModel.likesText,
                color: .green
            )

            reactionItem(
                icon: Constants.ImageStrings.handDownFill,
                value: viewModel.dislikesText,
                color: .red
            )

            Spacer()

            Image(systemName: Constants.ImageStrings.squareArrowUp)
                .font(.title3)
                .hidden()

            Image(systemName: Constants.ImageStrings.bookmark)
                .font(.title3)
                .hidden()
        }
        .font(.headline)
    }

    @ViewBuilder
    func reactionItem(icon: String, value: Int, color: Color) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
            Text("\(value)")
        }
        .foregroundColor(color)
    }
}
