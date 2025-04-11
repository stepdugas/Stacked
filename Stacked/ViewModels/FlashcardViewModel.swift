//
//  FlashcardViewModel.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//

import Foundation

// Manages all flashcard stacks and handles saving/loading with StackManager
class FlashcardViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var stacks: [FlashcardStack] = [] {
        didSet {
            saveStacks()
        }
    }
    
    @Published var selectedStackIndex: Int = 0
    @Published var currentCardIndex: Int = 0
    @Published var cards: [Flashcard] = []
    
    private let stackManager = StackManager()

    var currentStack: FlashcardStack? {
        guard stacks.indices.contains(selectedStackIndex) else { return nil }
        return stacks[selectedStackIndex]
    }
    
    var currentFlashcard: Flashcard? {
        guard let stack = currentStack,
              stack.cards.indices.contains(currentCardIndex) else {
            return nil
        }
        return stack.cards[currentCardIndex]
    }
    
    // MARK: - Init
    
    init() {
        loadStacks()
        
        // If no saved stacks, use sample data
        if stacks.isEmpty {
            stacks = [
                FlashcardStack(
                    title: "Swift Basics",
                    cards: [
                        Flashcard(front: "What is SwiftUI?", back: "A framework for building UIs with declarative syntax."),
                        Flashcard(front: "What is a ViewModel?", back: "A class that holds logic/data for views.")
                    ]
                ),
                FlashcardStack(
                    title: "Spanish",
                    cards: [
                        Flashcard(front: "Hola", back: "Hello"),
                        Flashcard(front: "Gracias", back: "Thank you")
                    ]
                )
            ]
        }
    }
    
    // MARK: - Stack Management
    
    func selectStack(at index: Int) {
        guard stacks.indices.contains(index) else { return }
        selectedStackIndex = index
        currentCardIndex = 0
    }

    func goToNextCard() {
        guard let stack = currentStack else { return }
        if currentCardIndex < stack.cards.count - 1 {
            currentCardIndex += 1
        } else {
            currentCardIndex = 0
        }
    }
    
    func shuffleCurrentStack() {
        guard var stack = currentStack else { return }
        stack.cards.shuffle()
        stacks[selectedStackIndex] = stack
        currentCardIndex = 0
    }

    // MARK: - Save/Load

    private func saveStacks() {
        stackManager.save(stacks)
    }
    
    private func loadStacks() {
        stacks = stackManager.load()
    }
    func resetAllStacks() {
        stacks.removeAll()
        // Save to disk if you're persisting data
    }
    func updateCards(for stack: FlashcardStack) {
        self.cards = stack.cards
    }
    func goToFirstCard() {
        currentCardIndex = 0
    }
}
