//
//  StackListView.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//
import SwiftUI

struct StackListView: View {
    @ObservedObject var viewModel: FlashcardViewModel
    @State private var showingNewStackPrompt = false
    @State private var newStackTitle = ""

    private let gridColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                // App Title
                Text("Stacked")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 24)

                // Scrollable grid of stacks
                ScrollView {
                    LazyVGrid(columns: gridColumns, spacing: 20) {
                        ForEach(viewModel.stacks.indices, id: \.self) { index in
                            let stack = viewModel.stacks[index]
                            NavigationLink(
                                destination: StackDetailView(viewModel: viewModel)
                                    .onAppear {
                                        viewModel.selectStack(at: index)
                                    },
                                label: {
                                    StackCardView(title: stack.title)
                                }
                            )
                        }
                    }
                    .padding()
                }

                Spacer()

                // Tab bar placeholder
                HStack(spacing: 30) {
                    ForEach(0..<4) { _ in
                        Circle()
                            .frame(width: 28, height: 28)
                            .foregroundColor(.gray.opacity(0.4))
                    }
                }
                .padding(.bottom, 16)
            }
            .navigationBarHidden(false) // Show nav bar so we can add toolbar
            .toolbar {
                // "+" button to add a new stack
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingNewStackPrompt = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
            .alert("New Stack", isPresented: $showingNewStackPrompt, actions: {
                TextField("Stack Title", text: $newStackTitle)
                Button("Create") {
                    let newStack = FlashcardStack(title: newStackTitle)
                    viewModel.stacks.append(newStack)
                    newStackTitle = ""
                }
                Button("Cancel", role: .cancel) {
                    newStackTitle = ""
                }
            })
        }
    }
}
