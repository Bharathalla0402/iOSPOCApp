//
//  MockView.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 22/05/26.
//

import Foundation
@testable import iOSPOCApp
import SwiftUI

func makeHostingView(post: Post) -> UIView {
    let viewModel = PostDetailViewModel(post: post)
    let view = PostDetailView(viewModel: viewModel)

    let host = UIHostingController(rootView: view)

    let scene = UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .first

    let window = UIWindow(windowScene: scene!)
    window.rootViewController = host
    window.makeKeyAndVisible()

    _ = host.view
    host.view.layoutIfNeeded()

    return host.view
}
