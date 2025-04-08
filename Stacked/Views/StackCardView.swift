//
//  StackCardView.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//
import SwiftUI

// Represents a single flashcard stack as a rectangle with a title
struct StackCardView: View {
    let title: String
    let color: Color

    var body: some View {
        Rectangle()
            .fill(color.opacity(0.2))
            .frame(height: 100)
            .cornerRadius(12)
            .overlay(
                Text(title)
                    .font(.headline)
                    .foregroundColor(color)
                    .padding()
            )
    }
}
