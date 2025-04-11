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
    @State private var showTitle = false

    private let gridColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                // App Title
                
                Text("Stacked")
                                       .font(.system(size: 42, weight: .bold, design: .rounded))
                                       .foregroundStyle(
                                           LinearGradient(
                                               colors: [Color.purple, Color.blue],
                                               startPoint: .leading,
                                               endPoint: .trailing
                                           )
                                       )
                                       .shadow(color: .black.opacity(0.25), radius: 4, x: 1, y: 2)
                                       .opacity(showTitle ? 1 : 0)
                                       .onAppear {
                                           withAnimation(.easeOut(duration: 2.0)) {
                                               showTitle = true
                                           }
                                       }

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
                                    StackCardView(
                                        title: stack.title,
                                        color: stack.color?.color ?? .blue
                                    )
                                }
                            )
                        }
                    }
                    .padding()
                }

                Spacer()

                
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
    
