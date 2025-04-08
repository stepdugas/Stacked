//
//  FlashcardEditorView.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//

import SwiftUI

struct FlashcardEditorView: View {
    // This binding allows the parent view to edit the flashcards directly
    @Binding var cards: [Flashcard]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Edit Flashcards")
                .font(.headline)
                .foregroundColor(.white)

            // Loop through the cards with their index
            ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                // Create two-way bindings for each card’s front and back
                let frontBinding = Binding<String>(
                    get: { cards[index].front },
                    set: { cards[index].front = $0 }
                )
                let backBinding = Binding<String>(
                    get: { cards[index].back },
                    set: { cards[index].back = $0 }
                )

                VStack(alignment: .leading, spacing: 8) {
                    Text("Card \(index + 1)")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    TextField("Front", text: frontBinding)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Back", text: backBinding)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(role: .destructive) {
                        cards.remove(at: index)
                    } label: {
                        Text("Delete Card")
                            .foregroundColor(.red)
                    }

                    Divider().background(Color.gray)
                }
                .padding(.vertical, 4)
            }
        }
    }
}
