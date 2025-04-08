//
//  FlashcardStack.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//
import Foundation

// This represents a full stack of flashcards for a specific subject or topic
struct FlashcardStack: Identifiable, Codable {
    let id: UUID
    var title: String       // e.g. "Math", "Spanish", "Swift Interview Prep"
    var cards: [Flashcard]  // The list of flashcards in the stack
    
    init(id: UUID = UUID(), title: String, cards: [Flashcard] = []) {
        self.id = id
        self.title = title
        self.cards = cards
    }
}

