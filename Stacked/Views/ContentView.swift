//
//  ContentView.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//

import SwiftUI

struct ContentView: View {
    // This creates a single instance of your ViewModel that lasts for the whole view hierarchy
    @StateObject var viewModel = FlashcardViewModel()

    var body: some View {
        // Pass the ViewModel into your stack list screen
        StackListView(viewModel: viewModel)
    }
}
