//
//  Flashcard.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//

import Foundation

// This struct represents a single flashcard in the app.
// It conforms to Identifiable so SwiftUI can loop over lists of flashcards easily.
struct Flashcard: Identifiable {
    
    // A unique ID for the flashcard, used by SwiftUI for rendering lists
    let id: UUID
    
    // The front of the flashcard (usually the question or term)
    let front: String
    
    // The back of the flashcard (usually the answer or explanation)
    let back: String
    
    // Optional category or subject (like "Math", "Spanish", etc.)
    let category: String?
    
    // You can add other metadata later like isFavorite, lastReviewedDate, etc.
    
    // This is an initializer so we can create flashcards easily
    init(id: UUID = UUID(), front: String, back: String, category: String? = nil) {
        self.id = id
        self.front = front
        self.back = back
        self.category = category
    }
}
