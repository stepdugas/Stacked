//
//  StackDetailView.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//

import SwiftUI

struct StackDetailView: View {
    @ObservedObject var viewModel: FlashcardViewModel
    @State private var isFlipped = false
    @State private var showingAddCardSheet = false
    @State private var frontText = ""
    @State private var backText = ""

    var body: some View {
        VStack {
            Spacer()

            // Flashcard container
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.orange.opacity(0.3))
                    .frame(height: 250)
                    .padding()

                Text(isFlipped ? viewModel.currentFlashcard?.back ?? "" : viewModel.currentFlashcard?.front ?? "")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .onTapGesture {
                withAnimation {
                    isFlipped.toggle()
                }
            }

            // Next button
            Button(action: {
                isFlipped = false
                viewModel.goToNextCard()
            }) {
                Text("Next")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .navigationTitle(viewModel.currentStack?.title ?? "Stack")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingAddCardSheet = true
                }) {
                    Image(systemName: "plus")
                        .font(.title2)
                }
            }
        }
        .sheet(isPresented: $showingAddCardSheet) {
            VStack(spacing: 20) {
                Text("Add a New Flashcard")
                    .font(.headline)

                TextField("Front (Question/Term)", text: $frontText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                TextField("Back (Answer/Definition)", text: $backText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button("Add Card") {
                    let newCard = Flashcard(front: frontText, back: backText)
                    if var stack = viewModel.currentStack {
                        stack.cards.append(newCard)
                        viewModel.stacks[viewModel.selectedStackIndex] = stack
                    }
                    frontText = ""
                    backText = ""
                    showingAddCardSheet = false
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)

                Button("Cancel", role: .cancel) {
                    showingAddCardSheet = false
                    frontText = ""
                    backText = ""
                }
            }
            .padding()
        }
    }
}
