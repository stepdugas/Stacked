//
//  StackManager.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//

import Foundation

// This class handles saving and loading flashcard stacks to the device
class StackManager {
    
    // Name of the file where we'll store the data
    private let fileName = "flashcard_stacks.json"
    
    // This is the file URL where we'll read/write the data
    private var fileURL: URL? {
        do {
            // Get the app’s documents directory
            let documents = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )
            return documents.appendingPathComponent(fileName)
        } catch {
            print("❌ Failed to get documents directory: \(error)")
            return nil
        }
    }

    // Save an array of stacks to disk
    func save(_ stacks: [FlashcardStack]) {
        guard let url = fileURL else { return }
        
        do {
            let data = try JSONEncoder().encode(stacks)
            try data.write(to: url)
            print("✅ Stacks saved to disk.")
        } catch {
            print("❌ Failed to save stacks: \(error)")
        }
    }
    
    // Load the stacks from disk and return them
    func load() -> [FlashcardStack] {
        guard let url = fileURL else { return [] }
        
        do {
            let data = try Data(contentsOf: url)
            let stacks = try JSONDecoder().decode([FlashcardStack].self, from: data)
            print("✅ Stacks loaded from disk.")
            return stacks
        } catch {
            print("⚠️ No saved stacks found, or failed to decode: \(error)")
            return []
        }
    }
}
