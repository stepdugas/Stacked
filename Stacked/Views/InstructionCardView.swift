//
//  InstructionCardView.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/11/25.
//

import SwiftUI

struct InstructionCardView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to your new stack!")
                .font(.title2)
                .bold()
            Text("Tap the ➕ button to add your first flashcard.\n\nSwipe left or right to move through cards.\n\nTap a card to flip it.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding()
    }
}
