//
//  DesignEditHomeView.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//
import SwiftUI

struct DesignEditHomeView: View {
    @ObservedObject var viewModel: FlashcardViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.stacks.indices, id: \.self) { index in
                    NavigationLink(destination: DesignEditView(
                        viewModel: viewModel,
                        initialStackIndex: index
                    )) {
                        HStack {
                            Circle()
                                .fill(viewModel.stacks[index].color?.color ?? .blue)
                                .frame(width: 20, height: 20)

                            Text(viewModel.stacks[index].title)
                        }
                    }
                }
            }
            .navigationTitle("Edit Stacks")
        }
    }
}
