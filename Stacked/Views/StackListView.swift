//
//  StackListView.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//
import SwiftUI

// This screen shows a grid of flashcard stacks and your app title at the top.
struct StackListView: View {
    // We pass in the ViewModel so this view can display and interact with the flashcard data
    @ObservedObject var viewModel: FlashcardViewModel

    // This defines the two-column layout for the stack grid
    private let gridColumns = [
        GridItem(.flexible()), // column 1
        GridItem(.flexible())  // column 2
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                // App Title
                Text("Stacked")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 24)
                
                // Scrollable grid of flashcard stacks
                ScrollView {
                    LazyVGrid(columns: gridColumns, spacing: 20) {
                        ForEach(viewModel.stacks.indices, id: \.self) { index in
                            let stack = viewModel.stacks[index]
                            StackCardView(title: stack.title)
                                .onTapGesture {
                                    viewModel.selectStack(at: index)
                                    // In the future: navigate to stack detail view
                                }
                        }
                    }
                    .padding()
                }

                Spacer()

                // Placeholder: Custom tab bar (drawn as 4 icons)
                HStack(spacing: 30) {
                    ForEach(0..<4) { _ in
                        Circle()
                            .frame(width: 28, height: 28)
                            .foregroundColor(.gray.opacity(0.4))
                    }
                }
                .padding(.bottom, 16)
            }
            .navigationBarHidden(true) // Hides default nav bar
        }
    }
}
