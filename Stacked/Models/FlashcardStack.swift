//
//  FlashcardStack.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//
import Foundation
import SwiftUI

struct FlashcardStack: Identifiable, Codable {
    let id: UUID
    var title: String
    var cards: [Flashcard]
    var color: CodableColor? 

    init(id: UUID = UUID(), title: String, cards: [Flashcard] = [], color: CodableColor? = nil) {
        self.id = id
        self.title = title
        self.cards = cards
        self.color = color
    }
}
