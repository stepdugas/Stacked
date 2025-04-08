//
//  Flashcard.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//

import Foundation

struct Flashcard: Identifiable, Codable {
    let id: UUID
    var front: String   // MUST be 'var'
    var back: String    // MUST be 'var'

    init(id: UUID = UUID(), front: String, back: String) {
        self.id = id
        self.front = front
        self.back = back
    }
}
