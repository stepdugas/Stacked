//
//  FlashcardViewModel.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//

import Foundation

// This class manages multiple flashcard stacks and tracks the active one
class FlashcardViewModel: ObservableObject {
    
    // This holds all the user's stacks (like "Math", "Spanish", etc.)
    @Published var stacks: [FlashcardStack] = []
    
    // This keeps track of the currently selected stack by its index
    @Published var selectedStackIndex: Int = 0
    
    // This keeps track of the index of the currently shown flashcard within the selected stack
    @Published var currentCardIndex: Int = 0
    
    // This computed property gives us the currently selected stack (if any exist)
    var currentStack: FlashcardStack? {
        guard stacks.indices.contains(selectedStackIndex) else { return nil }
        return stacks[selectedStackIndex]
    }
    
    // This gives us the flashcard currently being shown from the active stack
    var currentFlashcard: Flashcard? {
        guard let stack = currentStack,
              stack.cards.indices.contains(currentCardIndex) else {
            return nil
        }
        return stack.cards[currentCardIndex]
    }
    
    // MARK: - Initialization with sample data
    init() {
        // We'll start with two sample stacks for now
        let swiftStack = FlashcardStack(
            title: "Swift Basics",
            cards: [
                Flashcard(front: "What is SwiftUI?", back: "A framework for building UIs with declarative syntax."),
                Flashcard(front: "What is a ViewModel?", back: "A class that holds logic/data for views.")
            ]
        )
        
        let spanishStack = FlashcardStack(
            title: "Spanish",
            cards: [
                Flashcard(front: "Hola", back: "Hello"),
                Flashcard(front: "Gracias", back: "Thank you")
            ]
        )
        
        // Add them to our stacks array
        stacks = [swiftStack, spanishStack]
    }
    
    // MARK: - Flashcard navigation
    
    // Show the next card in the current stack
    func goToNextCard() {
        guard let stack = currentStack else { return }
        if currentCardIndex < stack.cards.count - 1 {
            currentCardIndex += 1
        } else {
            currentCardIndex = 0 // loop back to first card
        }
    }
    
    // Reset current card to the beginning when switching stacks
    func selectStack(at index: Int) {
        guard stacks.indices.contains(index) else { return }
        selectedStackIndex = index
        currentCardIndex = 0
    }
    
    // Optional: Shuffle the cards in the selected stack
    func shuffleCurrentStack() {
        guard var stack = currentStack else { return }
        stack.cards.shuffle()
        stacks[selectedStackIndex] = stack
        currentCardIndex = 0
    }
}
