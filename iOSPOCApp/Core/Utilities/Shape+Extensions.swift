//
//  Shape+Extensions.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

import SwiftUI

/*This extension lets us style any Shape by both stroking and filling it.*/
extension Shape {
    func style<S: ShapeStyle, F: ShapeStyle>(
            withStroke strokeContent: S,
            lineWidth: CGFloat = 1,
            fill fillContent: F
        ) -> some View {
            self.stroke(strokeContent, lineWidth: lineWidth)
                .background(fill(fillContent))
        }
}
