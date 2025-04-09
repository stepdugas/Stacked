//
//  MainTabView.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var viewModel = FlashcardViewModel()
    @State private var selectedTab = 0

    var body: some View {
        VStack(spacing: 0) {
            // Show the selected view
            Group {
                switch selectedTab {
                case 0:
                    StackListView(viewModel: viewModel)
                case 1:
                    DesignEditHomeView(viewModel: viewModel)
                case 2:
                    Text("TBD Feature View")
                case 3:
                    SettingsView()
                default:
                    Text("Unknown Tab")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Custom tab bar
            HStack {
                Spacer()
                tabBarButton(icon: "house", index: 0)
                Spacer()
                tabBarButton(icon: "paintbrush", index: 1)
                Spacer()
                tabBarButton(icon: "questionmark.circle", index: 2)
                Spacer()
                tabBarButton(icon: "person.circle", index: 3)
                Spacer()
            }
            .padding()
            .background(Color(.systemGray6))
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }

    // Reusable tab button
    private func tabBarButton(icon: String, index: Int) -> some View {
        Button(action: {
            selectedTab = index
        }) {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 24)
                .foregroundColor(selectedTab == index ? .blue : .gray)
        }
    }
}
