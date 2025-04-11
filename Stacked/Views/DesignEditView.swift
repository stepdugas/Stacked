//
//  DesignEditView.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//

import SwiftUI

struct DesignEditView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: FlashcardViewModel
    let initialStackIndex: Int
    @State private var selectedColor: Color = .blue
    @State private var newTitle: String = ""
    @State private var selectedStackIndex: Int

    init(viewModel: FlashcardViewModel, initialStackIndex: Int) {
        self.viewModel = viewModel
        self.initialStackIndex = initialStackIndex
        _selectedStackIndex = State(initialValue: initialStackIndex)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Stack Picker
                Text("Select a Stack to Edit")
                    .font(.headline)
                    .foregroundColor(.white)

                Picker("Stack", selection: $selectedStackIndex) {
                    ForEach(viewModel.stacks.indices, id: \.self) { index in
                        Text(viewModel.stacks[index].title).tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .colorMultiply(.white)

                Divider().background(Color.white)

                // Title editor
                Text("Edit Stack Title")
                    .font(.headline)
                    .foregroundColor(.white)

                TextField("Enter new title", text: $newTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Divider().background(Color.white)

                // Color Theme Picker
                Text("Choose a Stack Color")
                    .font(.headline)
                    .foregroundColor(.white)

                ForEach(colorPacks) { pack in
                    VStack(alignment: .leading) {
                        Text(pack.name)
                            .font(.subheadline)
                            .foregroundColor(.white)

                        HStack {
                            ForEach(pack.colors, id: \.self) { color in
                                Circle()
                                    .fill(color)
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white.opacity(selectedColor == color ? 0.8 : 0), lineWidth: 3)
                                    )
                                    .onTapGesture {
                                        selectedColor = color
                                    }
                            }
                        }
                    }
                    .padding(.bottom, 5)
                }

                Divider().background(Color.white)

                // Flashcard editor (modular view)
                FlashcardEditorView(cards: $viewModel.stacks[selectedStackIndex].cards)

                // Save Button
                Button(action: {
                    saveChanges()
                    dismiss()
                }) {
                    Text("Save Changes")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
            .padding()
        }
        .background(Color.black)
        .navigationTitle("Design & Edit")
        .onAppear {
            loadStack(at: selectedStackIndex)
        }
        .onChange(of: selectedStackIndex) {
            loadStack(at: $0)
        }
    }

    // MARK: - Stack Helpers

    private func loadStack(at index: Int) {
        guard viewModel.stacks.indices.contains(index) else { return }
        let stack = viewModel.stacks[index]
        selectedColor = stack.color?.color ?? .blue
        newTitle = stack.title
    }

    private func saveChanges() {
        guard viewModel.stacks.indices.contains(selectedStackIndex) else { return }

        var updatedStack = viewModel.stacks[selectedStackIndex]
        updatedStack.title = newTitle
        updatedStack.color = CodableColor(color: selectedColor)
        viewModel.stacks[selectedStackIndex] = updatedStack
    }
}
